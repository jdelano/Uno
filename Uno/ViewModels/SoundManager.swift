//
//  SoundManager.swift
//  Uno
//
//  Created by John Delano on 11/18/24.
//

enum SoundEffect: String {
    case playCard = "playcard"
    case dealCard = "dealcard"
    case wrongSpot = "wrongspot"
    case playWild = "playwild"
}

import AVFoundation

@MainActor
class SoundManager {
    static let shared = SoundManager()
    private var audioPlayers: [AVAudioPlayer] = []
    
    func playSound(_ effect: SoundEffect) {
        Task {
            await self._playSound(named: effect.rawValue)
        }
    }
    
    private func _playSound(named soundName: String) async {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound \(soundName) not found.")
            return
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer.play()
            
            audioPlayers.append(audioPlayer)
            
            try await Task.sleep(nanoseconds: UInt64(audioPlayer.duration * 1_000_000_000))
            
            if let index = audioPlayers.firstIndex(of: audioPlayer) {
                audioPlayers.remove(at: index)
            }
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
    
}
