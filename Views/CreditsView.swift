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
    Reference(title: "illustrations (character, background, icon, map)", source: "created for the APP",
              author: "João Mergulhão (owner)",
              obs: "The cave painting illustrations are based on public available images provided by Museum of the American Man Foundation (FUMDHAM)"),
    Reference(title: "Background sound", source: "https://opengameart.org/content/ambient-bird-sounds",
              author: "isaiah658"),
    Reference(title: "Footstep sound", source: "https://opengameart.org/content/nature-sounds-pack",
              author: "Antoine Gaumain"),
    Reference(title: "SF Pro Font", source: "https://developer.apple.com/fonts/",
              author: "Apple")
]

let reseachRef: [String] = [
    "http://fumdham.org.br",
    "https://www.smithsonianmag.com/science-nature/essential-timeline-understanding-evolution-homo-sapiens-180976807/",
    "https://www.researchgate.net/publication/336899695",
    "https://brasil.mongabay.com/2023/07/niede-guidon-50-anos-na-defesa-da-serra-da-capivara-maior-tesouro-rupestre-das-americas/",
    "https://whc.unesco.org/en/documents/128814",
    "https://whc.unesco.org/en/list/606/",
    "https://agenciagov.ebc.com.br/noticias/202308/primeiro-sitio-arqueologico-descoberto-na-serra-da-capivara-completa-50-anos",
    "https://viajento.com/2023/03/23/serra-da-capivara-serra-branca/"
]

struct CreditsView: View {
    var body: some View {
        ZStack{
            Color.mapBg
                .ignoresSafeArea()
            
            ScrollView{
                VStack{
                    Text("ABOUT ME")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.redTitle)
                        .padding(.vertical, 24)
                    HStack{
                        Spacer()
                        
                        Image("bubble2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 310)
                            .overlay{
                                Text("Hi, I am **João Mergulhão**, a brazilian Computer Science student passionated about technology, art and history")
                                    .font(.system(size: 18))
                                    .padding(.leading, 10)
                                    .padding(.trailing, 38)
                                    .multilineTextAlignment(.center)
                            }
                        
                        
                        
                        Image("myself")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 160)
                        
                        Spacer()
                    }
                    .padding(.bottom, 44)
                    
                    Text("CREDITS")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.redTitle)
                        .padding(.vertical, 24)
                    
                    ForEach(references, id: \.self){ ref in
                        ZStack{
                            Color.parkBoardBg
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.darkBrown, lineWidth: 4)
                                )
                            VStack{
                                
                                Text(ref.title)
                                .font(.system(size: 18, weight: .bold))
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
                            .padding(.horizontal, 20)
                        }
                        .font(.system(size: 16))
                        .foregroundStyle(Color.redTitle)
                        .padding(.bottom, 12)
                    }
                    
                    ZStack{
                        Color.parkBoardBg
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.darkBrown, lineWidth: 4)
                            )
                        VStack{
                            Text("Research References")
                                .font(.system(size: 16, weight: .bold))
                            
                            ForEach(reseachRef, id: \.self){ ref in
                                Text(ref)
                                    .padding(.vertical, 4)
                            }
                            
                        }
                        .padding()
                        .padding(.horizontal, 20)
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(Color.redTitle)
                    .padding(.bottom, 12)
                }
                .padding(.horizontal, 80)
            }
        }
    }
}

#Preview {
    CreditsView()
}
