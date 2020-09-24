//
//  EggTimerObject.swift
//  EggTimer-SwiftUI
//
//  Created by Kwin Sirikwin on 21/8/20.
//  Copyright © 2020 Kwin Sirikwin. All rights reserved.
//

import SwiftUI
import AVFoundation
import Combine

class EggTimerObject: ObservableObject {
    
    @Published var timeElapsed: TimeInterval = .zero
    @Published var timeTotal: TimeInterval = .greatestFiniteMagnitude

    var eggTimer: AnyCancellable?
    
    func startCountDown(duration: TimeInterval, step: TimeInterval) {
        eggTimer?.cancel()
        timeElapsed = .zero
        timeTotal = duration
        
        eggTimer = Timer.publish(every: step, on: RunLoop.main, in: .common)
            .autoconnect()
            .sink(receiveValue: { (_) in
                if self.timeElapsed < duration {
                    self.timeElapsed += step
                    print(self.timeElapsed)
                } else {
                    self.eggTimer?.cancel()
                    WAVSounds.playSounds(soundfile: "alarm_sound", filetype: "mp3")
                }
            })
    }
}

class WAVSounds {
    
    static var audioPlayer:AVAudioPlayer?
    
    static func playSounds(soundfile: String, filetype: String) {
        if let url = Bundle.main.url(forResource: soundfile, withExtension: filetype) {
            do {
                
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                
            } catch {
                print("Audio Player Error")
            }
        }
    }
}
