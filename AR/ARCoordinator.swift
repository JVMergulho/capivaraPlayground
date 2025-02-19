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

//TODO: Bug fix - when the coaching doesnt appear nothing works

class ARCoordinator: NSObject, @preconcurrency ARSessionDelegate, @preconcurrency ARCoachingOverlayViewDelegate, ObservableObject {
    
    var arView: ARView?
    @Published var enableButton: Bool = false
    @Published var showButton: Bool = true
    @Published var paintingWasPlaced: Bool = false
    @Published var showFocusSquare: Bool = false
    @Published var infoSelected: Bool = false
    var selectedSite: Site?
    
    var overlayActivated: Bool = false
    
    var focusIndicator: ModelEntity?
    var infoBoard: ModelEntity?
    
    @MainActor func setup(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        arView?.addGestureRecognizer(tapGesture)
        
        setupFocusIndicator()
    }
    
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
        overlayActivated = false
        
        if let focusIndicator{
            focusIndicator.anchor?.removeChild(focusIndicator)
        }
        
        setupFocusIndicator()
    }
    
    func updateSite(site: Site){
        selectedSite = site
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
        
        // Adiciona um CollisionComponent para permitir interações
        focusIndicator?.components[CollisionComponent.self] = CollisionComponent(shapes: [.generateBox(size: [0.3, 0.001, 0.3])])
        
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

        if let hitEntity = arView?.entity(at: tapLocation) {
            
            if hitEntity == infoBoard{
                print("Board Taped")
                infoSelected.toggle()
            }
            
            if hitEntity == focusIndicator{
                print("focus Taped")
                addPainting()
            }
            
            return
        }
    }

    @MainActor func addPlane(worldPosition: SIMD3<Float>, worldRotation: simd_quatf, size: CGPoint, imageName: String) -> ModelEntity? {
        guard let arView,
              let texture = imageToTexture(named: imageName) else {
            return nil
        }
        
        let anchor = AnchorEntity(world: worldPosition)
                
        let planeMesh = MeshResource.generatePlane(width: Float(size.x), depth: Float(size.y))
    
        let baseColor = MaterialParameters.Texture(texture)
    
        var planeMaterial = UnlitMaterial()
        planeMaterial.color = SimpleMaterial.BaseColor(tint: .white, texture: baseColor)
        planeMaterial.blending = .transparent(opacity: 1.0)

        let planeEntity = ModelEntity(mesh: planeMesh, materials: [planeMaterial])
        
        planeEntity.components[CollisionComponent.self] = CollisionComponent(shapes: [.generateBox(size: [Float(size.x), 0.001, Float(size.y)])])

        // Aplica a rotação do plano base ao plano adicionado
        planeEntity.orientation = worldRotation

        anchor.addChild(planeEntity)
        arView.scene.addAnchor(anchor)
        
        return planeEntity
    }

    @MainActor
    func addPainting() {
        guard let focusIndicator, let selectedSite else { return }
        
        let basePosition = focusIndicator.position
        
        _ = addPlane(worldPosition: basePosition, worldRotation: focusIndicator.transform.rotation, size: CGPoint(x: 0.6, y: 0.6), imageName: selectedSite.painting)
        
        let rightVector = SIMD3(x: focusIndicator.transform.matrix.columns.0.x,
                                y: focusIndicator.transform.matrix.columns.0.y,
                                z: focusIndicator.transform.matrix.columns.0.z)
        
        let upVector = SIMD3(x: focusIndicator.transform.matrix.columns.2.x,
                             y: focusIndicator.transform.matrix.columns.2.y,
                             z: focusIndicator.transform.matrix.columns.2.z)

        // Calcular nova posição da âncora
        let boardPosition = basePosition - (rightVector * 0.4) - (upVector * 0.2)
        
        self.infoBoard = addPlane(worldPosition: boardPosition, worldRotation: focusIndicator.transform.rotation, size: CGPoint(x: 0.2, y: 0.2), imageName: selectedSite.infoBoard)
    
        DispatchQueue.main.async {
            self.enableButton = false
            self.paintingWasPlaced = true
            self.disableFocus()
        }
    }
}
