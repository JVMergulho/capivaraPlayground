//
//  CreditsView.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 20/02/25.
//

import SwiftUI

struct Reference: Hashable{
    let title: String
    let source: String
    let author: String
}

let references: [Reference] = [
    Reference(title: "Background sound", source: "https://opengameart.org/content/ambient-bird-sounds",
              author: "isaiah658"),
    Reference(title: "Footstep sound", source: "https://opengameart.org/content/nature-sounds-pack",
              author: "Antoine Gaumain"),
    Reference(title: "SF Pro Font", source: "https://developer.apple.com/fonts/",
              author: "Apple")
]

struct CreditsView: View {
    var body: some View {
        ZStack{
            Color.mapBg
                .ignoresSafeArea()
            
            ScrollView{
                VStack{
                    Text("About Me")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color.redTitle)
                        .padding()
                    HStack{
                        Image(.bubble3)
                            .resizable()
                            .overlay{
                                Text("I am **João Mergulhão**, a brazilian Computer Science student passionated about technology, art and history")
                                    .font(.system(size: 14))
                                    .padding(.leading, 5)
                                    .padding(.trailing, 26)
                                    .multilineTextAlignment(.center)
                            }
                        
                        Image("myself")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 160)
                    }
                    .padding(.bottom, 24)
                    
                    Text("Credits")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color.redTitle)
                        .padding()
                    
                    ForEach(references, id: \.self){ ref in
                        ZStack{
                            Color.parkBoardBg
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.darkBrown, lineWidth: 4)
                                )
                            VStack{
                                HStack{
                                    Text(ref.title)
                                        .font(.system(size: 16, weight: .bold))
                                    Spacer()
                                }
                                .padding(.bottom, 8)
                                
                                HStack{
                                    Text("Source:")
                                    Spacer()
                                    Text(ref.source)
                                }
                                
                                HStack{
                                    Text("Author:")
                                    Spacer()
                                    Text(ref.author)
                                }
                            }
                            .padding()
                        }
                        .font(.system(size: 14))
                        .foregroundStyle(Color.redTitle)
                        .padding(.bottom, 12)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    CreditsView()
}
