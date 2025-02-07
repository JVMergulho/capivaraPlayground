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
                
                VStack{
                    Image(.titleCapivara)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    Image(.caveTexture)
                        .resizable()
                        .scaledToFit()
                }
                
                VStack{
                    MapView(selectedSite: $selectedSite)
                        .padding()
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
            .toolbar(){
                Button(action: {
                    path.append(Page.timeline)
                }){
                    Image(systemName: "book.pages.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.redTitle)
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
