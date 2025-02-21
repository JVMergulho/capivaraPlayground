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
    var obs: String?
}

let references: [Reference] = [
    Reference(title: "Illustrations (capybaras, background, map)", source: "created for the APP",
              author: "João Mergulhão (owner)"),
    Reference(title: "Cave Painting illustrations", source: "created for the APP",
              author: "João Mergulhão (owner)",
              obs: "Based on public available images provided by Fundação Museu do Homem Americano (FUNDHAM)"),
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
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.redTitle)
                        .padding()
                    HStack{
                        Image(.bubble2)
                            .resizable()
                            .scaledToFit()
                            .overlay{
                                Text("Hi, I am **João Mergulhão**, a brazilian Computer Science student passionated about technology, art and history")
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
                        .font(.system(size: 24, weight: .bold))
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
                                        .font(.system(size: 14, weight: .semibold))
                                    Spacer()
                                    Text(ref.source)
                                }
                                
                                HStack{
                                    Text("Author:")
                                        .font(.system(size: 14, weight: .semibold))
                                    Spacer()
                                    Text(ref.author)
                                }
                                
                                if let obs = ref.obs{
                                    Text("Observation:")
                                        .font(.system(size: 14, weight: .semibold))
                                        .padding(.top, 8)
                                    Spacer()
                                    Text(obs)
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
