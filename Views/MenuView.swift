//
//  SwiftUIView.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 06/02/25.
//

import SwiftUI

struct MenuView: View {
    let screenWidth = UIScreen.main.bounds.width
    
    @Binding var path: NavigationPath
    
    var body: some View {
            ZStack{
                Color.sky
                
                // clouds behind the rock
                MovingClouds()
                
                VStack{
                    Spacer()
                    
                    Image(.pedraFurada)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth)
                }
                
                VStack{
                    Image(.capivaraIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                    
                    Image(.titleCapivara)
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 40)
                        .frame(width: screenWidth)
                        
                    Spacer()
                    
                    RedButton(title: "Enter Park"){
                        path.append(Page.map)
                        print("Apertou")
                        print(path)
                    }
                    .padding(.bottom, 34)
                    
                    RedButton(title: "Credits"){
                        path.append(Page.credits)
                    }
                }
                .padding(.vertical, 68)
            }.ignoresSafeArea()
    }
}

#Preview {
    MenuView(path: .constant(NavigationPath()))
}
