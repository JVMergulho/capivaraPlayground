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
        
        coordinator.arView = arView
        
        coordinator.setup()
        
        //arView.debugOptions = .showAnchorGeometry
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
