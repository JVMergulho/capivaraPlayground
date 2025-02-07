//
//  ARViewContainer.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 03/02/25.
//

import SwiftUI
import ARKit
import RealityKit
//import FocusEntity
import UIKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var showButton: Bool
    @ObservedObject var coordinator: Coordinator
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)
        arView.session.delegate = coordinator
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical, .horizontal]
        arView.session.run(configuration)
        
        let coachingOverlay = ARCoachingOverlayView()
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
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        DispatchQueue.main.async {
            // check if the painting was already placed
            if !coordinator.paintingWasPlaced{
                self.showButton = true
            }
        }
    }
}

class Coordinator: NSObject, ARSessionDelegate, ARCoachingOverlayViewDelegate, ObservableObject {
    //var focusEntity: FocusEntity?
    var arView: ARView?
    @Published var showButton: Bool = false
    @Published var paintingWasPlaced: Bool = false
    
//    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
//    }
    
    @MainActor
    func addPainting(painting: String) {
        guard let arView = arView else { return }
        
        guard let image = UIImage(named: painting) else {
            print("Painting image not found")
            return
        }
        guard let imageURL = imageToURL(image: image) else { return }
        
        let texture = try! TextureResource.load(contentsOf: imageURL)
        let planeMesh = MeshResource.generatePlane(width: 0.5, depth: 0.5)
        
        let baseColor = MaterialParameters.Texture(texture)
        
        var material = UnlitMaterial()
        material.color = SimpleMaterial.BaseColor(tint: .white, texture: baseColor)
        material.blending = .transparent(opacity: 1.0)
        
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
        
        let anchor = AnchorEntity(world: SIMD3<Float>(0, 0, 0))
        anchor.addChild(planeEntity)
        
        // Align plane with FocusEntity orientation
        // planeEntity.transform.rotation = focusEntity.transform.rotation
        
        arView.scene.addAnchor(anchor)
        
        DispatchQueue.main.async {
            self.showButton = false
            self.paintingWasPlaced = true
        }
    }
}
