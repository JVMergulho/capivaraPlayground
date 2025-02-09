//
//  ParkBoardView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 09/02/25.
//

import SwiftUI

struct ParkBoardView: View {
    var body: some View {
        ZStack{
            Color.white
                .frame(width: 308, height: 168)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.darkBrown, lineWidth: 6)
                )
            VStack{
                Text("Serra da Capivara")
                    .font(.system(size: 30, weight: .bold))
                HStack{
                    Image(.brazil)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28)
                    
                    Text("National Park")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Image(.serraLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                }
                
                Rectangle()
                    .frame(width: 260)
                    .frame(height: 2)
                
                Text("State of Piauí, Brazil")
                    .font(.system(size: 14, weight: .medium))
                    .padding(.bottom, 4)
                
                Text("Founded in 1979")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundStyle(Color.greenTitle)
        }
    }
}

#Preview {
    ParkBoardView()
}
