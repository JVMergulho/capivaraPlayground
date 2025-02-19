import AVFoundation
import Combine

class AudioManager: ObservableObject {
    
    private var audioPlayer: AVAudioPlayer?
    private var effectPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    
    init() {
        setup(&audioPlayer, filename: "birds", loops: true)
        setup(&effectPlayer, filename: "footstep", volume: 1.0, loops: false)
        
        self.isPlaying = true
        audioPlayer?.play()
    }
    
    private func setup(_ player: inout AVAudioPlayer?, filename: String, withExtension ext: String = "mp3", volume: Float = 0.2, loops: Bool = true) {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
            print("Erro: Audio file \(filename).\(ext) not found.")
            return
        }
        
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: fileURL)
            newPlayer.numberOfLoops = loops ? -1 : 0
            newPlayer.volume = volume
            player = newPlayer
        } catch {
            print("Failed to initialize audio: \(error)")
        }
    }
    
    func toggle() {
        guard let audioPlayer else { return }
        
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
        isPlaying = audioPlayer.isPlaying
    }
    
    func playEffect() {
        guard let effectPlayer else { return }
        
        if isPlaying {
            effectPlayer.currentTime = 0
            effectPlayer.play()
        }
    }
}
