//
//  TipView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 13/02/25.
//

import SwiftUI

struct TipView: View {
    
    let capivaraImage: ImageResource
    let text: Text
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                
                VStack{
                    Spacer()
                    
                    HStack{
                        Image(.bubble2)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                            .frame(width: 208)
                            .overlay(){
                                text
                                    .padding(.trailing, 26)
                                    .padding(.leading, 4)
                                    .multilineTextAlignment(.center)
                            }
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 70)
                .padding(.leading, 20)
                
                HStack{
                    Image(capivaraImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .frame(width: 260)
                        .offset(x: geometry.size.width * 0.3, y: geometry.size.height * 0.45)
                }
            }
        }
    }
}

#Preview {
    TipView(capivaraImage: .capivara2, text: Text("**Select a pin** to visit an archeological site!"))
}
