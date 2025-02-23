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
    @State var showTimeButton = false
    
    @Binding var path: NavigationPath
    
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
            ZStack{
                Color.mapBg
                    .ignoresSafeArea()
                
                Image("caveTexture")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                VStack{
                    
                    ParkBoardView(title: "Park Map")
                        .padding(.top, 34)
                    
                    MapView(selectedSite: $selectedSite)
                        .padding(.horizontal, 80)
                    
                    Spacer(minLength: 280)
                }
                
                if showTimeButton{
                    TipView(capivaraImage: "capivara2", path: $path, showButton: true)
                } else {
                    TipView(capivaraImage: "capivara2",text: Text("**Select a pin** to visit an archeological site!"), path: $path)
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
                    showTimeButton.toggle()
                }
            }
            .animation(.easeInOut(duration: 0.4), value: showWarning)
            .toolbar(){
            if !showWarning{
                ToolbarItemGroup(){
                    Button(action: {
                        audioManager.toggle()
                    }){
                        if (audioManager.isPlaying){
                            Image(systemName: "speaker.fill")
                                .foregroundStyle(Color.redTitle)
                                .font(.system(size: 28))
                        } else {
                            Image(systemName: "speaker.slash.fill")
                                .foregroundStyle(Color.redTitle)
                                .font(.system(size: 28))
                        }
                    }
                    
                    Button(action: {
                        path.append(Page.timeline)
                    }){
                        Image(systemName: "book.circle.fill")
                            .foregroundStyle(Color.redTitle)
                            .font(.system(size: 28))
                    }
                }
            } else {
                ToolbarItemGroup(placement: .topBarLeading){
                    Button(action: {
                        showWarning = false
                    }){
                        Text("Cancel")
                            .foregroundStyle(Color.redTitle)
                            .font(.system(size: 28))
                    }
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
