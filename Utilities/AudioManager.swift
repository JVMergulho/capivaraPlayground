//
//  AudioManager.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 13/02/25.
//

import AVFoundation

class AudioManager: ObservableObject {
    
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    
    init() {}
    
    func setupAndPlay(filename: String, withExtension ext: String = "mp3", volume: Float = 0.2, loops: Bool = true) {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
            print("Erro: Audio file \(filename).\(ext) not found.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.numberOfLoops = loops ? -1 : 0
            audioPlayer?.volume = volume
            audioPlayer?.play()
            isPlaying = true
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
    
    func stop() {
        audioPlayer?.stop()
        isPlaying = false
    }
}

