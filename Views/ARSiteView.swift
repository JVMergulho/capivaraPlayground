//
//  ARSiteView.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 05/02/25.
//

import SwiftUI

struct ARSiteView: View {
    @StateObject private var coordinator = ARCoordinator()
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
        }
    }
}
