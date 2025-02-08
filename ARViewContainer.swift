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
        // addPlaneIndicator(to: arView)
        
        //arView.debugOptions = .showAnchorGeometry
        
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

class Coordinator: NSObject, @preconcurrency ARSessionDelegate, @preconcurrency ARCoachingOverlayViewDelegate, ObservableObject {
    var arView: ARView?
    @Published var showButton: Bool = false
    @Published var paintingWasPlaced: Bool = false
    
    var focusIndicator: ModelEntity?
    
    @MainActor func setupFocusIndicator() {
        let planeMesh = MeshResource.generatePlane(width: 0.3, depth: 0.3)
        //let planeMaterial = SimpleMaterial(color: .yellow, isMetallic: false)
    
        guard let texture = imageToTexture(named: "target") else {
            print("Failed to create texture")
            return
        }
        
        let baseColor = MaterialParameters.Texture(texture)
    
        var planeMaterial = UnlitMaterial()
        planeMaterial.color = SimpleMaterial.BaseColor(tint: .white, texture: baseColor)
        planeMaterial.blending = .transparent(opacity: 1.0)
        
        focusIndicator = ModelEntity(mesh: planeMesh, materials: [planeMaterial])
        focusIndicator?.isEnabled = false
        
        guard let arView, let focusIndicator else { return }
        
        let anchor = AnchorEntity(world: SIMD3<Float>(0, 0, 0)) // Inicialmente na origem
        anchor.addChild(focusIndicator)
        arView.scene.addAnchor(anchor)
    }
    
    @MainActor func updateFocusIndicator() {
        guard let arView = arView, let focusIndicator = focusIndicator else { return }

        let viewportCenter = CGPoint(x: arView.bounds.midX, y: arView.bounds.midY)
        let raycastResults = arView.raycast(from: viewportCenter, allowing: .estimatedPlane, alignment: .any)

        if let result = raycastResults.first {
            let worldPos = result.worldTransform.translation
            let worldRotation = simd_quatf(result.worldTransform) // Ajusta orientação

            // Atualiza posição e orientação do indicador
            focusIndicator.position = worldPos
            focusIndicator.orientation = worldRotation
            focusIndicator.isEnabled = true
        } else {
            // Oculta o indicador se não houver plano detectado
            focusIndicator.isEnabled = false
        }
    }
    
    @MainActor func session(_ session: ARSession, didUpdate frame: ARFrame) {
        updateFocusIndicator()
    }
    
    @MainActor func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        arView?.addGestureRecognizer(tapGesture)
        setupFocusIndicator()
    }
    
    @MainActor @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: arView)
        print("Toque realizado na posição: \(tapLocation)")

        // Perform a raycast
        let raycastResults = arView?.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
        
        if let result = raycastResults?.first {
            let worldPos = result.worldTransform.translation
            let worldRotation = simd_quatf(result.worldTransform)
            print("Coordenada 3D do toque: \(worldPos)")

            // Adiciona o plano com a rotação correta
            addPlane(worldPosition: worldPos, worldRotation: worldRotation)
        } else {
            print("Nenhum plano detectado no local do toque.")
        }
    }

    @MainActor func addPlane(worldPosition: SIMD3<Float>, worldRotation: simd_quatf) {
        guard let arView = arView else { return }
        
        let anchor = AnchorEntity(world: worldPosition)

        let planeMesh = MeshResource.generatePlane(width: 0.1, depth: 0.1)
        let planeMaterial = SimpleMaterial(color: .blue, isMetallic: false)
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [planeMaterial])

        // Aplica a rotação do plano base ao plano adicionado
        planeEntity.orientation = worldRotation

        anchor.addChild(planeEntity)
        arView.scene.addAnchor(anchor)
    }

    
    @MainActor
    func addPainting(painting: String) {
        guard let arView = arView else { return }
    
//        guard let image = UIImage(named: painting) else {
//            print("Painting image not found")
//            return
//        }
//        guard let imageURL = imageToURL(image: image) else { return }
    
        //let texture = try! TextureResource.load(contentsOf: imageURL)
        
        guard let texture = imageToTexture(named: painting) else { return }
        
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

extension simd_float4x4 {
    var translation: SIMD3<Float> {
        return SIMD3(x: columns.3.x, y: columns.3.y, z: columns.3.z)
    }
}
