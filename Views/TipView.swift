//
//  TipView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 13/02/25.
//

import SwiftUI

struct TipView: View {
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
                            .frame(width: 220)
                            .overlay(){
                                Text("Tap in the yellow board to get more information about this site")
                                    .padding(.trailing, 26)
                                    .padding(.leading, 4)
                                    .multilineTextAlignment(.center)
                            }
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 80)
                .padding(.leading, 20)
                
                HStack{
                    Image(.capivara3)
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
    TipView()
}
