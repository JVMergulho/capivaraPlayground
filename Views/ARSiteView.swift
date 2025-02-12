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
                    }
                }
            }
            .padding(.bottom, 24)
            
            if coordinator.showFocusSquare{
                Image(.focusSquare)
                    .resizable()
                    .frame(width: 120, height: 120)
            }
            
            if showInfo{
                InfoBoardView(infoPresented: $showInfo)
            }
        }
        .onChange(of: coordinator.infoSelected){
            showInfo = true
        }
        .animation(.easeInOut(duration: 0.6), value: showInfo)
    }
}
