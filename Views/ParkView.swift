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
    
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.mapBg
                    .ignoresSafeArea()
                
                Image(.caveTexture)
                    .resizable()
                    .scaledToFit()
                
                VStack{
                    
                    ParkBoardView(title: "Park Map")
                        .padding(.top)
                    
                    MapView(selectedSite: $selectedSite)
                        .padding(.horizontal)
                    
                    Spacer(minLength: 200)
                }
                
                TipView(capivaraImage: .capivara2, text: Text("**Select a pin** to visit the archeological site!"))
                
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
        .toolbar(){
            ToolbarItemGroup(){
                Button(action: {
                    audioManager.toggle()
                }){
                    if (audioManager.isPlaying){
                        Image(systemName: "speaker.fill")
                            .foregroundStyle(Color.redTitle)
                    } else {
                        Image(systemName: "speaker.slash.fill")
                            .foregroundStyle(Color.redTitle)
                    }
                }
                
                Button(action: {
                    path.append(Page.timeline)
                }){
                    Image("bookIcon")
                }
            }
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
