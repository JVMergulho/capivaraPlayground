//
//  MainView.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 06/02/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct ParkView: View {
    @State var selectedSite: Site?
    
    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.mapBg
                    .ignoresSafeArea()
                
                Image(.caveTexture)
                    .resizable()
                    .scaledToFit()
                
                VStack{
                    
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            path.append(Page.timeline)
                        }){
                            Image("bookIcon")
                        }
                        .padding(.trailing, 20)
                    }
                    
                    ParkBoardView()
                    
                    MapView(selectedSite: $selectedSite)
                        .padding()
                    
                    Spacer()
                }
            }
            .onChange(of: selectedSite){
                if let site = selectedSite {
                    print("Visiting \(site.name)")
                    path.append(Page.arSite(site))
                    
                    // reset site
                    selectedSite = nil
                }
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        ParkView(selectedSite: nil, path: .constant(NavigationPath()))
    } else {
        // Fallback on earlier versions
    }
}
