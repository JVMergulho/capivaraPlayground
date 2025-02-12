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
    @State var showWarning = false
    
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
                
                if showWarning{
                    WarningView(path: $path, showWarning: $showWarning, selectedSite: selectedSite!)
                        .onDisappear(){
                            selectedSite = nil
                        }
                }
            }
            .onChange(of: selectedSite){
                if selectedSite != nil{
                    showWarning.toggle()
                }
            }
            .animation(.easeInOut(duration: 0.4), value: showWarning)
        }
        .navigationBarBackButtonHidden(showWarning)
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        ParkView(selectedSite: nil, path: .constant(NavigationPath()))
    } else {
        // Fallback on earlier versions
    }
}
