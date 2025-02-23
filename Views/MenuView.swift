import SwiftUI

@available(iOS 17.0, *)
struct MenuView: View {
    @Binding var path: NavigationPath
    @State var offsetY = 0.1
    @State var offsetYClouds = 0.1
    @State var showIntro = false
    @State var showButtons = true
    let animationDuration = 1.5
    @EnvironmentObject var audioManager: AudioManager
    
    var body: some View {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                
                ZStack {
                    Color.sky
                        .ignoresSafeArea()
                    
                    // Nuvens ao fundo
                    MovingClouds()
                    .offset(y: screenHeight * offsetYClouds - 400)
                    .animation(.easeInOut(duration: animationDuration), value: offsetYClouds)
                    
                    VStack {
                        if showButtons {
                            Image("capivaraIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth * 0.2) // Ajuste proporcional para iPad
                            
                            Image("titleCapivara")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal, 80)
                                .frame(width: screenWidth * 0.7)
                        }
                        
                        Spacer()
                        
                        Image("pedraFurada")
                            .resizable()
                            .scaledToFill()
                            .frame(width: screenWidth)
                            .clipped()
                    }
                    .offset(y: screenHeight * offsetY)
                    .animation(.easeInOut(duration: animationDuration), value: offsetY)
                    
                    if showButtons {
                        VStack {
                            
                            Spacer()
                            
                            RedButton(title: "Enter Park") {
                                offsetY = 0.02
                                showButtons = false
                                audioManager.playEffect()
                            }
                            .padding(.bottom, 80)
                            .frame(width: screenWidth * 0.4, height: 60)
                            
                            RedButton(title: "Credits") {
                                path.append(Page.credits)
                                audioManager.playEffect()
                            }
                            .frame(width: screenWidth * 0.4, height: 60)
                        }
                        .padding(.bottom, 480)
                    }
                    
                    if showIntro {
                        IntroView(path: $path)
                    }
                }
                .ignoresSafeArea()
                .onChange(of: showButtons){
                    if showButtons == false{
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration){
                            showIntro = true
                        }
                    }
                }
                .onChange(of: offsetY){
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration){
                        offsetYClouds = offsetY
                    }
                }
                .animation(.easeInOut(duration: 0.6), value: showIntro)
                .onDisappear {
                    resetMenu()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("")
                }
                
                ToolbarItemGroup {
                    Button(action: {
                        audioManager.toggle()
                    }) {
                        Image(systemName: audioManager.isPlaying ? "speaker.fill" : "speaker.slash.fill")
                            .foregroundStyle(Color.redTitle)
                            .font(.system(size: 24))
                    }
                }
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
    }
}

@available(iOS 17.0, *)
extension MenuView {
    func resetMenu() {
        showIntro = false
        showButtons = true
        offsetY = 0.1
        offsetYClouds = 0.1
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        MenuView(path: .constant(NavigationPath()))
            .previewDevice("iPad Pro (11-inch) (4th generation)")
    } else {
        // Fallback para versões anteriores
    }
}
