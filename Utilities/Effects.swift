//
//  Effects.swift
//  capivARa
//
//  Created by João Vitor Lima Mergulhão on 14/02/25.
//

import SpriteKit
import Foundation
import AVFoundation

class Effect {
    var audioPlayerNode = AVAudioPlayerNode()
    var audioPitchTime = AVAudioUnitTimePitch()
    
    var audioFile: AVAudioFile
    var audioBuffer: AVAudioPCMBuffer
    var engine: AVAudioEngine
    
    var name: String
    var isPlaying: Bool = false
    
    init?(forSound sound: String) {
        do {
            audioPlayerNode.stop()
            
            name = sound
            engine = AVAudioEngine()
            
            let soundFile = NSURL(fileURLWithPath: Bundle.main.path(forResource: sound, ofType: "mp3")!) as URL
            try audioFile = AVAudioFile(forReading: soundFile)
            
            if let buffer = AVAudioPCMBuffer(pcmFormat: audioFile.processingFormat, frameCapacity: AVAudioFrameCount(audioFile.length)) {
                audioBuffer = buffer
                try audioFile.read(into: audioBuffer)
                
                engine.attach(audioPlayerNode)
                engine.attach(audioPitchTime)
                engine.connect(audioPlayerNode, to: audioPitchTime, format: audioBuffer.format)
                engine.connect(audioPitchTime, to: engine.mainMixerNode, format: audioBuffer.format)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func play(pitch: Float = 0.0, speed: Float = 1.0, volume: Float = 3.0) {
        if !engine.isRunning {
            engine.reset()
            try! engine.start()
        }
        audioPlayerNode.play()
        audioPlayerNode.volume = max(0.0, min(volume, 1.0))
        audioPitchTime.pitch = pitch
        audioPitchTime.rate = speed
        audioPlayerNode.scheduleBuffer(audioBuffer) {
            self.isPlaying = false
        }
        isPlaying = true
    }
    
    func stop() {
        audioPlayerNode.stop()
        isPlaying = false
    }
}
