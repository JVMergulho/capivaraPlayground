//
//  Intro.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 09/02/25.
//

import SwiftUI

struct IntroView: View {
    @Binding var path: NavigationPath
    @State var currentFrame = 0
    
    @EnvironmentObject var audioManager: AudioManager
    
    var showPrev: Bool {
        return currentFrame > 0
    }
    var showNext: Bool {
        return currentFrame < dialogs.count - 1
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Image(.bubble1)
                .resizable()
                .scaledToFit()
                .frame(width: 340)
                .overlay(){
                    VStack{
                        dialogs[currentFrame].text
                            .frame(height: 180)
                        
                        HStack{
                            if showPrev{
                                Button(action: {
                                    prevFrame()
                                }){
                                    Image(systemName: "arrowshape.left.fill")
                                        .resizable()
                                        .frame(width: 22, height: 22)
                                        .foregroundStyle(Color.redTitle)
                                }
                            }
                            
                            Spacer()
                            
                            if showNext{
                                Button(action: {
                                    nextFrame()
                                }){
                                    Image(systemName: "arrowshape.right.fill")
                                        .resizable()
                                        .frame(width: 22, height: 22)
                                        .foregroundStyle(Color.redTitle)
                                        
                                }
                            } else {
                                Button(action:{
                                    path.append(Page.map)
                                    audioManager.playEffect()
                                }){
                                    Text("Continue")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundStyle(.white)
                                        .frame(width: 110, height: 42)
                                        .background( Color.redTitle)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                }
                            }
                        }
                        .frame(height: 40)
                        .padding(.bottom, 80)
                    }
                    .frame(width: 300, height: 180)
                }
                .padding(.top, 60)

                HStack {
                    Image(dialogs[currentFrame].image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                        .offset(x: geometry.size.width * 0.2, y: geometry.size.height * 0.47)
                }
                .frame(width: geometry.size.width)
            }
            .onDisappear(){
                currentFrame = 0
            }
        }
        .ignoresSafeArea()
    }
    
    func nextFrame(){
        if currentFrame < dialogs.count - 1{
            currentFrame += 1
            audioManager.playEffect()
        }
    }
    
    func prevFrame(){
        if currentFrame > 0 {
            currentFrame -= 1
            audioManager.playEffect()
        }
    }
}

//extension IntroView{
//    
//    func typeWriter(at position: Int = 0) {
//        let text = dialogs[currentFrame].text
//        guard position < text.count else { return }
//        
//        let index = text.index(text.startIndex, offsetBy: position)
//        
//        self.dialogText += String(text[index])
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.015) {
//            typeWriter(at: position + 1)
//        }
//    }
//}

#Preview {
    IntroView(path: .constant(NavigationPath()))
}
