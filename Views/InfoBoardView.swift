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
        ZStack{
            Color.grayBg
                .opacity(0.5)
                .ignoresSafeArea()
            
            ScrollView{
                VStack{
                    
                    HStack{
                        Spacer()
                        
                        Button(action:{
                            infoPresented = false
                        }){
                            Image(systemName: "xmark.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .foregroundStyle(Color.redTitle)
                        }
                    }
                    Image(.infoPedraFurada)
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 48)
        }
    }
}

#Preview {
    InfoBoardView(infoPresented: .constant(true))
}
