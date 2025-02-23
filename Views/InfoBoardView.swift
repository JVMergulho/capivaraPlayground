//
//  infoBoardView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 11/02/25.
//

import SwiftUI

struct InfoBoardView: View {
    @Binding var infoPresented: Bool
    let selectedSite: Site
    
    var body: some View {
        
        ZStack{
            
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 20){
                    
                    HStack{
                        Spacer()
                        
                        Button(action:{
                            infoPresented = false
                        }){
                            Image("closeIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundStyle(Color.redTitle)
                        }
                    }
                    
                    Image(selectedSite.infoBoard)
                        .resizable()
                        .scaledToFit()
                    
                    TextBoxView( infoType: .painting, text: selectedSite.paintingAbout)
                    .padding(.bottom, 16)
                    
                    TextBoxView( infoType: .site, text: selectedSite.siteAbout)
                    
                    Spacer()
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 80)
            .scrollIndicators(.hidden)
        }
    }
}

enum InfoType: String{
    case site = "Site"
    case painting = "Painting"
}

#Preview {
    InfoBoardView(infoPresented: .constant(true), selectedSite: Sites[1])
}
