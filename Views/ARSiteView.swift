//
//  ARSiteView.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 05/02/25.
//

import SwiftUI

struct ARSiteView: View {
    @StateObject private var coordinator = Coordinator()
    let selectedSite: Site
    
    var body: some View {
        ZStack {
            ARViewContainer(showButton: $coordinator.showButton, coordinator: coordinator)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                
                if coordinator.showButton {
                    Button(action: {
                        coordinator.addPainting(painting: selectedSite.painting)
                    }) {
                        Text("Place Painting")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.bottom, 24)
        }
    }
}
