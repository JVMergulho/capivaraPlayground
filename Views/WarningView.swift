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
            
            VStack(spacing: 48){
                
                Spacer()
                
                HStack{
                    Text("**Augmented Reality Experience**")
                        .font(.system(size: 32))
                }
                .padding(.bottom, 32)
                
                Text("You will visualize a cave painting located in the site you chose projected in a horizontal or vertical plane.")
                
                Text("However, you are only able to place the painting when this symbol is appearing:")
                
                Image("target")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                
                Text("It means that the APP is detecting a projectable plane.")
                
                Text("**Tip:** for a better experience go to a well-lit place ")
                
                Spacer()
                
                RedButton(title: "Continue"){
                    path.append(Page.arSite(selectedSite))
                    showWarning = false
                    audioManager.playEffect()
                }
            }
            .multilineTextAlignment(.center)
            .font(.system(size: 20))
            .padding(.horizontal, 180)
            .padding(.bottom, 120)
        }
    }
}

//#Preview {
//    WarningView()
//}
