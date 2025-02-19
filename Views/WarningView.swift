//
//  WarningView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 12/02/25.
//

import SwiftUI

struct WarningView: View {
    @Binding var path: NavigationPath
    @Binding var showWarning: Bool
    let selectedSite: Site
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
        ZStack{
            Color.mapBg
                .ignoresSafeArea()
            
            VStack(spacing: 28){
                
                HStack{
                    Text("This is an ")
                        .font(.system(size: 24))
                    + Text("Augmented Reality")
                        .font(.system(size: 24))
                        .bold()
                    + Text(" Experience")
                        .font(.system(size: 24))
                }
                .padding(.vertical, 16)
                
                Text("You will visualize a cave painting located in the site you chose projected in a horizontal or vertical plane.")
                
                Text("However, you are only able to place the painting when this symbol is appearing:")
                
                Image(.target)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                
                Text("It means that the APP is detecting a projectable plane.")
                    .padding(.bottom, 12)
                
                Spacer()
                
                RedButton(title: "Continue"){
                    path.append(Page.arSite(selectedSite))
                    showWarning = false
                    audioManager.playEffect()
                }
                .padding(.bottom, 24)
            }
            .multilineTextAlignment(.center)
            .font(.system(size: 20))
            .padding(.horizontal, 32)
        }
    }
}

//#Preview {
//    WarningView()
//}
