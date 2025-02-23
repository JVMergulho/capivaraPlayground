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
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack {
                // Balão de fala
                
                VStack{
                    Image("bubble1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth * 0.5) // Ajustado para iPad
                        .overlay {
                            VStack {
                                dialogs[currentFrame].text
                                    .font(.system(size: 22))
                                    .animation(.easeInOut(duration: 0.2), value: currentFrame)
                                    .frame(height: 240)
                                    .padding(.horizontal, 8)
                                
                                HStack {
                                    if showPrev {
                                        Button(action: {
                                            prevFrame()
                                        }) {
                                            Image(systemName: "arrowshape.left.fill")
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                                .foregroundStyle(Color.redTitle)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    if showNext {
                                        Button(action: {
                                            nextFrame()
                                        }) {
                                            Image(systemName: "arrowshape.right.fill")
                                                .resizable()
                                                .frame(width: 32, height: 32)
                                                .foregroundStyle(Color.redTitle)
                                        }
                                    } else {
                                        Button(action: {
                                            path.append(Page.map)
                                            audioManager.playEffect()
                                        }) {
                                            Text("Continue")
                                                .font(.system(size: 24, weight: .medium))
                                                .foregroundStyle(.white)
                                                .frame(width: 130, height: 50)
                                                .background(Color.redTitle)
                                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                        }
                                    }
                                }
                                .frame(height: 50)
                                .padding(.bottom, 100)
                            }
                            .frame(width: screenWidth * 0.45, height: 200)
                        }
                        .padding(.top, 250)
                    
                    Spacer()
                }
                
                // Personagem
                Image(dialogs[currentFrame].image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth * 0.6) // Ajustado para iPad
                    .offset(y: screenHeight * 0.23)
                    .offset(x: screenWidth * 0.15)
                    //.clipped()
            }
            .frame(width: screenWidth, height: screenHeight)
            .onDisappear {
                currentFrame = 0
            }
        }
        .ignoresSafeArea()
    }
    
    func nextFrame() {
        if currentFrame < dialogs.count - 1 {
            currentFrame += 1
            audioManager.playEffect()
        }
    }
    
    func prevFrame() {
        if currentFrame > 0 {
            currentFrame -= 1
            audioManager.playEffect()
        }
    }
}

#Preview {
    IntroView(path: .constant(NavigationPath()))
}
