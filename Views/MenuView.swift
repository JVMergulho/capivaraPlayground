//
//  SwiftUIView.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 06/02/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct MenuView: View {
    let screenWidth = UIScreen.main.bounds.width
    
    @Binding var path: NavigationPath
    @State var offsetY = 0.2
    @State var showIntro = false
    let animationDuration = 0.6
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Color.sky
                
                // clouds behind the rock
                VStack{
                    MovingClouds()
                }
                .offset(y: geometry.size.height * offsetY - 120)
                .animation(.easeInOut(duration: animationDuration), value: offsetY)
                
                VStack{
                    
                    if !showIntro{
                        Image(.capivaraIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                        
                        Image(.titleCapivara)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 40)
                            .frame(width: screenWidth)
                    }
                    
                    Spacer()
                    
                    Image(.pedraFurada3)
                        .resizable()
                        .scaledToFit()
                        //.frame(width: screenWidth)
                        .clipped()
                        
                }
                .offset(y: geometry.size.height * offsetY)
                .animation(.easeInOut(duration: animationDuration), value: offsetY)
                
                if !showIntro{
                    VStack{
                        Spacer()
                        
                        RedButton(title: "Enter Park"){
                            offsetY = 0
                        }
                        .padding(.bottom, 34)
                        
                        RedButton(title: "Credits"){
                            path.append(Page.credits)
                        }
                    }
                    .padding(.vertical, 68)
                } else {
                    IntroView(path: $path)
                }
                
            }
            .ignoresSafeArea()
            .onChange(of: offsetY){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
                    showIntro = true
                }
            }
            .animation(.easeInOut(duration: 0.6), value: showIntro)
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        MenuView(path: .constant(NavigationPath()))
    } else {
        // Fallback on earlier versions
    }
}
