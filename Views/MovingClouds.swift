//
//  MovingClouds.swift
//  capivara
//
//  Created by João Vitor Lima Mergulhão on 07/02/25.
//

import SwiftUI

struct MovingClouds: View {
    let screenWidth = UIScreen.main.bounds.width
    @State private var offset1: CGFloat = 0
    @State private var offset2: CGFloat = UIScreen.main.bounds.width
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                Image(.clouds)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth)
                    .offset(x: offset1, y: 0)
                
                Image(.clouds)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth)
                    .offset(x: offset2, y: 0)
            }
            .onReceive(timer) { _ in
                withAnimation(.linear(duration: 0.02)) {
                    offset1 -= 0.7
                    offset2 -= 0.7
                    
                    if offset1 <= -screenWidth {
                        offset1 = screenWidth
                    }
                    if offset2 <= -screenWidth {
                        offset2 = screenWidth
                    }
                }
            }
            .padding(.bottom, 80)
        }
    }
}
