//
//  Intro.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 09/02/25.
//

import SwiftUI

struct Capivara{
    let text: String
    let image: String
}

let frames = [
    Capivara(text: "Hi, I am Niède", image: "capivara1"),
    Capivara(text: "Hi, I am Niède", image: "capivara2"),
    Capivara(text: "Hi, I am Niède", image: "capivara3")
]

struct IntroView: View {
    
    @State var currentFrame = 0
    
    var showPrev: Bool {
        return currentFrame > 0
    }
    var showNext: Bool {
        return currentFrame < frames.count
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                VStack{
                    Text(frames[currentFrame].text)
                    
                    HStack{
                        
                        if showPrev{
                            Button(action: {
                                prevFrame()
                            }){
                                Image(systemName: "arrowtriangle.right.fill")
                                    .rotationEffect(Angle(degrees: 180))
                                    .foregroundStyle(Color.redTitle)
                            }
                        }
                        
                        if showNext{
                            Button(action: {
                                nextFrame()
                            }){
                                Image(systemName: "arrowtriangle.right.fill")
                                    .foregroundStyle(Color.redTitle)
                            }
                        }
                    }
                }

                HStack {
                    Image(frames[currentFrame].image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .offset(x: geometry.size.width * 0.15, y: geometry.size.height * 0.03)
                }
                .frame(width: geometry.size.width)
            }
            .frame(height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
    
    func nextFrame(){
        if currentFrame < frames.count{
            currentFrame += 1
        }
    }
    
    func prevFrame(){
        if currentFrame > 0 {
            currentFrame -= 1
        }
    }
}



#Preview {
    IntroView()
}
