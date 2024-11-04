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
    typealias Card = UnoGame.Card
    private var selectedCards: Set<Card> = []
    
    var currentPlayerIndex: Int {
        model.currentPlayerIndex
    }
    
    var topDiscardCard: Card? {
        model.topDiscardCard
    }
    
    
    init(players: [String]) {
        self.model = UnoGame(players: players)
    }
    
    func cards(forPlayerIndex index: Int) -> [Card] {
        model.players[index].hand.allItems
    }
    
    func colorForCard(_ card: Card) -> Color {
        switch card.color {
            case .red: return .red
            case .yellow: return .yellow
            case .blue: return .blue
            case .green: return .green
            case .wild: return .black
        }
    }
    
    func isCardSelected(_ card: Card) -> Bool {
        selectedCards.contains(card)
    }
    // MARK: - Intents
    
    func nextPlayer() {
        model.nextPlayer()
    }
    
    func resetGame() {
        model.resetGame()
    }
    
    func toggleSelectedCard(_ card: Card) {
        if isCardSelected(card) {
            selectedCards.remove(card)
        } else {
            selectedCards.insert(card)
        }
    }
    
    func playCard(_ card: UnoGame.Card) {
        if let discardCard = topDiscardCard, card.canPlay(on: discardCard) {
            model.playCard(card)
        }
    }
    
    func dealCard() {
        model.drawCardsForCurrentPlayer(1)
    }

}
