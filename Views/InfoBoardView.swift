//
//  infoBoardView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 11/02/25.
//

import SwiftUI

struct InfoBoardView: View {
    @Binding var infoPresented: Bool
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                
                HStack{
                    Spacer()
                    
                    Button(action:{
                        infoPresented = false
                    }){
                        Image(.closeIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .foregroundStyle(Color.redTitle)
                    }
                }
                
                Image(.infoPedraFurada)
                    .resizable()
                    .scaledToFit()
                
                TextBoxView( infoType: .painting, text: """
                 A notable rock painting in Brazil's Serra da Capivara National Park depicts two capybaras, a mother and her offspring, symbolizing the park due to the historical presence of these animals in the region. 

                 Above them, two human figures are shown alongside another animal, possibly illustrating prehistoric daily life activities such as hunting or rituals, highlighting interactions between early inhabitants and local fauna. 
                 """)
                .padding(.bottom, 16)
                
                TextBoxView( infoType: .site, text: """
                 Toca do Boqueirão da Pedra Furada (or simply known as Pedra Furada) is probably the most well- known tourist site in the region. Pedra Furada translates to pierced stone.

                 The site presents are accepted to belong to the ‘northeast tradition’ and in it are represented the characteristics of the various evolutionary moments of this tradition.
                 """)
                
                Spacer()
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 48)
        .scrollIndicators(.hidden)
    }
}

enum InfoType: String{
    case site = "Site"
    case painting = "Painting"
}

#Preview {
    InfoBoardView(infoPresented: .constant(true))
}
