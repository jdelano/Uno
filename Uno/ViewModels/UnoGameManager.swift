//
//  UnoGameManager.swift
//  Uno
//
//  Created by John Delano on 9/18/24.
//

import SwiftUI

class UnoGameManager {
    private var model: UnoGame
    
    init(players: [String]) {
        self.model = UnoGame(players: players)
    }
    
    func cards(forPlayerIndex index: Int) -> [UnoGame.Card] {
        model.players[index].hand
    }
    
    func colorForCard(_ card: UnoGame.Card) -> Color {
        switch card.color {
            case "Red": return .red
            case "Yellow": return .yellow
            case "Blue": return .blue
            case "Green": return .green
            default: return .black
        }
    }
}
