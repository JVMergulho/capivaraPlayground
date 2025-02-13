//
//  AudioManager.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 13/02/25.
//

import AVFoundation

class AudioManager {
    @MainActor static let shared = AudioManager() // Singleton
    
    private var AudioPlayer: AVAudioPlayer?

    private init() {}

    func setupAndPlay(filename: String, withExtension ext: String = "mp3", volume: Float = 0.5, loops: Bool = true) {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
            print("Erro: arquivo de música \(filename).\(ext) não encontrado.")
            return
        }

        do {
            AudioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            AudioPlayer?.numberOfLoops = loops ? -1 : 0
            AudioPlayer?.volume = volume
            AudioPlayer?.play()
        } catch {
            print("Falha ao iniciar o áudio: \(error)")
        }
    }

    func stop() {
        AudioPlayer?.stop()
    }

    func pause() {
        AudioPlayer?.pause()
    }

    func resume() {
        AudioPlayer?.play()
    }

    func setVolume(_ volume: Float) {
        AudioPlayer?.volume = volume
    }
    
    func updateAudioState(isMusicOn: Bool) {
        if isMusicOn {
            AudioPlayer?.play()
        } else {
            AudioPlayer?.stop()
        }
    }
}
