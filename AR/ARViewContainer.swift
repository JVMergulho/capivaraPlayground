//
//  ARViewContainer.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 03/02/25.
//

import SwiftUI
import ARKit
import RealityKit
import UIKit

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var coordinator: ARCoordinator
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)
        arView.session.delegate = coordinator
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical, .horizontal]
        arView.session.run(configuration)
        
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.setActive(true, animated: true)
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = arView.session
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        coachingOverlay.goal = .anyPlane
        coachingOverlay.delegate = coordinator
        arView.addSubview(coachingOverlay)
        
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: arView.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: arView.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: arView.heightAnchor)
        ])
        
        coordinator.arView = arView
        
        coordinator.setup()
        
        //arView.debugOptions = .showAnchorGeometry
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
