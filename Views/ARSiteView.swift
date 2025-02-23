//
//  ARSiteView.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 05/02/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct ARSiteView: View {
    @StateObject private var coordinator = ARCoordinator()
    @State var showInfo: Bool = false
    @State var infoWasPresented: Bool = false
    @EnvironmentObject var audioManager: AudioManager
    
    @Binding var path: NavigationPath

    let selectedSite: Site
    
    var body: some View {
        ZStack {
            ARViewContainer(coordinator: coordinator)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                if coordinator.showButton{
                    RedButton(title: "Place Painting", disabled: !coordinator.enableButton){
                        coordinator.addPainting()
                        audioManager.playEffect()
                    }
                }
            }
            .padding(.bottom, 120)
            
            if coordinator.showFocusSquare{
                Image("focusSquare")
                    .resizable()
                    .frame(width: 180, height: 180)
            }
            
            if coordinator.paintingWasPlaced && !infoWasPresented{
                TipView(capivaraImage: "capivara3", text: Text("**Tap in the yellow sign** to get more information about this site!"), path: $path)
            }
            
            if showInfo{
                InfoBoardView(infoPresented: $showInfo, selectedSite: selectedSite)
            }
        }
        .onChange(of: coordinator.infoSelected){
            showInfo = true
            infoWasPresented = true
        }
        .onAppear(){
            coordinator.updateSite(site: selectedSite)
        }
        .animation(.easeInOut(duration: 0.6), value: showInfo)
        .animation(.easeInOut(duration: 0.6), value: coordinator.paintingWasPlaced)
    }
}
