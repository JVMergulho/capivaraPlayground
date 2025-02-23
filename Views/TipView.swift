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
                            text
                                .padding(.trailing, 34)
                                .font(.system(size: 24))
                                .multilineTextAlignment(.center)
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
            .padding(.trailing, 80)
        }
    }
}

#Preview {
    TipView(capivaraImage: "capivara2", text: Text("**Select a pin** to visit an archeological site!"))
}
