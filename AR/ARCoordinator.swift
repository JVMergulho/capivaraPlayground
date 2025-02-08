//
//  ARCoordinator.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 08/02/25.
//
import SwiftUI
import ARKit
import RealityKit
import UIKit

class ARCoordinator: NSObject, @preconcurrency ARSessionDelegate, @preconcurrency ARCoachingOverlayViewDelegate, ObservableObject {
    var arView: ARView?
    @Published var enableButton: Bool = false
    @Published var showButton: Bool = true
    @Published var paintingWasPlaced: Bool = false
    @Published var showFocusSquare: Bool = false
    var overlayActivated: Bool = false
    
    var focusIndicator: ModelEntity?
    
    @MainActor func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // only show focus indicator before the painting was placed
        if !paintingWasPlaced{
            
            updateFocusIndicator()
            
            if let focusIndicator{
                self.enableButton = focusIndicator.isEnabled
            }
        } else {
            showButton = false
        }
        
        if !enableButton && !overlayActivated && !paintingWasPlaced{
            showFocusSquare = true
        } else {
            showFocusSquare = false
        }
    }
    
    @MainActor func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        overlayActivated = true
    }
    
    @MainActor func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        arView?.addGestureRecognizer(tapGesture)
        overlayActivated = false
        
        if let focusIndicator{
            focusIndicator.anchor?.removeChild(focusIndicator)
        }
        
        setupFocusIndicator()
    }
    
    @MainActor func setupFocusIndicator() {
        let planeMesh = MeshResource.generatePlane(width: 0.3, depth: 0.3)
    
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

        if overlayActivated{
            focusIndicator.isEnabled = false
        } else {
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
        
    }
    
    @MainActor func disableFocus(){
        print("focusIndicator disbled")
        focusIndicator?.isEnabled = false
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
        guard let arView, let focusIndicator else { return }
        
        guard let texture = imageToTexture(named: painting) else { return }
        
        let planeMesh = MeshResource.generatePlane(width: 0.5, depth: 0.5)
    
        let baseColor = MaterialParameters.Texture(texture)
    
        var material = UnlitMaterial()
        material.color = SimpleMaterial.BaseColor(tint: .white, texture: baseColor)
        material.blending = .transparent(opacity: 1.0)
    
        let planeEntity = ModelEntity(mesh: planeMesh, materials: [material])
    
        let anchor = AnchorEntity(world: focusIndicator.position)
        anchor.addChild(planeEntity)
    
        // Align plane with FocusEntity orientation
        planeEntity.transform.rotation = focusIndicator.transform.rotation
    
        arView.scene.addAnchor(anchor)
    
        DispatchQueue.main.async {
            self.enableButton = false
            self.paintingWasPlaced = true
            self.disableFocus()
        }
    }
}
