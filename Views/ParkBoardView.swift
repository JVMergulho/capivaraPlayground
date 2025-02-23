//
//  ParkBoardView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 09/02/25.
//

import SwiftUI

struct ParkBoardView: View {
    let title: String
    
    var body: some View {
        ZStack{
            Color.parkBoardBg
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.darkBrown, lineWidth: 8)
                )
            VStack{
                HStack(spacing: 32){
                    Image("brazil")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)

                    Text(title)
                        .font(.system(size: 34, weight: .bold))
                        .padding(.horizontal)
                    
                    Image("serraLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
                .padding(.bottom, 8)
                
                Rectangle()
                    .frame(width: 480)
                    .frame(height: 2)
                    .padding(.bottom, 8)
                
                Text("Serra da Capivara National Park")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.bottom, 2)
            }
            .foregroundStyle(Color.greenTitle)
        }
        .frame(height: 140)
        .padding(.horizontal, 80)
    }
}

#Preview {
    ParkBoardView(title: "Park Map")
}
