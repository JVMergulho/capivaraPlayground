//
//  TipView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 13/02/25.
//

import SwiftUI

struct TipView: View {
    
    let capivaraImage: String
    let text: Text
    let showButton: Bool
    @Binding var path: NavigationPath
    
    @EnvironmentObject var audioManager: AudioManager
    
    init(capivaraImage: String, text: Text = Text(""), path: Binding<NavigationPath>, showButton: Bool = false) {
        self.capivaraImage = capivaraImage
        self.text = text
        self.showButton = showButton
        self._path = path
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack {
                VStack {
                    Spacer()
                    
                    Image("bubble2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth * 0.35)
                        .overlay {
                            
                            if showButton{
                                VStack{
                                    Text("Learn more about the past by visiting the")
                                        .font(.system(size: 24))
                                        .multilineTextAlignment(.center)
                                    
                                    Button(action: {
                                        path.append(Page.timeline)
                                        audioManager.playEffect()
                                    }) {
                                        HStack{
                                            Text("Timeline")
                                                .font(.system(size: 24, weight: .medium))
                                                .foregroundStyle(.white)
                                            Image(systemName: "book.fill")
                                                .foregroundStyle(Color.mapBg)
                                        }
                                        .frame(width: 160, height: 50)
                                        .background(Color.redTitle)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                    }
                                }
                                .padding(.trailing, 34)
                            } else {
                                text
                                    .padding(.leading, 12)
                                    .padding(.trailing, 40)
                                    .font(.system(size: 24))
                                    .multilineTextAlignment(.center)
                            }
                        }
                }
                .padding(.bottom, screenHeight * 0.08)
                .padding(.trailing, screenWidth * 0.1)
                
                // Capivara
                HStack {
                    Spacer()
                    
                    Image(capivaraImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screenWidth * 0.35) // Ajustado para iPad
                        .offset(y: screenHeight * 0.42)
                }
            }
            .foregroundStyle(Color.black)
            .padding(.trailing, 80)
        }
    }
}

#Preview {
    TipView(capivaraImage: "capivara2", text: Text("**Select a pin** to visit an archeological site!"), path: .constant(NavigationPath()))
}
