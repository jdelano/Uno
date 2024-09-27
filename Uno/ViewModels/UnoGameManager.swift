//
//  UnoGameManager.swift
//  Uno
//
//  Created by John Delano on 9/18/24.
//

import SwiftUI

@Observable
class UnoGameManager {
    private var model: UnoGame
    
    init(players: [String]) {
        self.model = UnoGame(players: players)
    }
    
    func cards(forPlayerIndex index: Int) -> [UnoGame.Card] {
        model.players[index].hand.allItems
    }
    
    func colorForCard(_ card: UnoGame.Card) -> Color {
        switch card.color {
            case .red: return .red
            case .yellow: return .yellow
            case .blue: return .blue
            case .green: return .green
            case .wild: return .black
        }
    }
    
    // MARK: - Intents
    
    func resetGame() {
        model.resetGame()
    }
}
