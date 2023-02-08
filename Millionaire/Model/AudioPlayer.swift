//
//  AudioPlayer.swift
//  Millionaire
//
//  Created by Vitali Martsinovich on 2023-02-08.
//

import Foundation
import AVFoundation

struct AudioPlayer {
    
    var player: AVAudioPlayer!
    
    mutating func playSound(soundName: String) {
        
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
}
