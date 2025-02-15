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
                        .stroke(Color.darkBrown, lineWidth: 6)
                )
            VStack{
                HStack{
                    Image(.brazil)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)

                    Text(title)
                        .font(.system(size: 30, weight: .bold))
                        .padding(.horizontal)
                    
                    Image(.serraLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                }
                .padding(.bottom, 2)
                
                Rectangle()
                    .frame(width: 260)
                    .frame(height: 2)
                    .padding(.bottom, 2)
                
                Text("Serra da Capivara National Park")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.bottom, 2)
            }
            .foregroundStyle(Color.greenTitle)
        }
        .frame(height: 108)
        .padding(.horizontal, 20)
    }
}

#Preview {
    ParkBoardView(title: "Park Map")
}
