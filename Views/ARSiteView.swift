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

    let selectedSite: Site
    
    var body: some View {
        ZStack {
            ARViewContainer(coordinator: coordinator)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                if coordinator.showButton{
                    RedButton(title: "Place Painting", disabled: !coordinator.enableButton){
                        coordinator.addPainting(painting: selectedSite.painting)
                        audioManager.playEffect()
                    }
                }
            }
            .padding(.bottom, 24)
            
            if coordinator.showFocusSquare{
                Image(.focusSquare)
                    .resizable()
                    .frame(width: 120, height: 120)
            }
            
            if coordinator.paintingWasPlaced && !infoWasPresented{
                TipView(capivaraImage: .capivara3, text: Text("**Tap in the yellow board** to get more information about this site!"))
            }
            
            if showInfo{
                InfoBoardView(infoPresented: $showInfo)
            }
        }
        .onChange(of: coordinator.infoSelected){
            showInfo = true
            infoWasPresented = true
        }
        .animation(.easeInOut(duration: 0.6), value: showInfo)
        .animation(.easeInOut(duration: 0.6), value: coordinator.paintingWasPlaced)
    }
}
