//
//  TextBoxView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 12/02/25.
//
import SwiftUI

struct TextBoxView: View {
    
    let infoType: InfoType
    let text: String
    
    var body: some View {
        ZStack{
            Color.mapBg
            
            VStack{
                Text("About the \(infoType.rawValue)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.redTitle)
                    .padding(.top, 16)
                
                if infoType == .painting {
                    Image(.curveLine)
                } else {
                    Image(.straightLine)
                }
                
                Text(text)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 16)
        }
        .cornerRadius(16)
    }
}
