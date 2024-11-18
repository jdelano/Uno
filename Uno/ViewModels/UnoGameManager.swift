//
//  UnoGameManager.swift
//  Uno
//
//  Created by John Delano on 9/18/24.
//

import SwiftUI


extension UserDefaults {
    func unoGame(forKey key: String) -> UnoGame? {
        if let jsonData = data(forKey: key),
           let decodedUnoGame = try? JSONDecoder().decode(UnoGame.self, from: jsonData) {
            return decodedUnoGame
        } else {
            return nil
        }
    }
    
    func set(_ unoGame: UnoGame, forKey key: String) {
        let data = try? JSONEncoder().encode(unoGame)
        set(data, forKey: key)
    }
}


@Observable
class UnoGameManager {
    private let userDefaultKey = "UnoGame.Settings"
    
    private var model: UnoGame {
        didSet {
            let defaults = UserDefaults.standard
            defaults.set(model, forKey: userDefaultKey)
        }
    }
    
    
    typealias Card = UnoGame.Card
    private var selectedCards: Set<Card> = []
    var isChoosingColor: Bool = false
    var wildColor: Color {
        switch model.wildColor {
            case .red:
                return .red
            case .blue:
                return .blue
            case .green:
                return .green
            case .yellow:
                return .yellow
            default:
                return .clear
        }
    }
    
    
    
    var currentPlayerIndex: Int {
        model.currentPlayerIndex
    }
    
    var topDiscardCard: Card? {
        model.topDiscardCard
    }
    
    var playerNames: [String] {
        get { model.playerNames }
        set { model.playerNames = newValue }
    }
    
    init(players: [String]) {
        if let savedGame = UserDefaults.standard.unoGame(forKey: userDefaultKey) {
            self.model = savedGame
        } else {
            self.model = UnoGame(players: players)
            UserDefaults.standard.set(self.model, forKey: userDefaultKey)
        }
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
    
    @MainActor
    func playCard(_ card: UnoGame.Card) {
        if let discardCard = topDiscardCard, card.canPlay(on: discardCard, wildColor: model.wildColor) {
            if card.type.isWildCard {
                isChoosingColor = true
                playSound(.playWild)
            } else {
                playSound(.playCard)
            }
            model.playCard(card)
        } else {
            playSound(.wrongSpot)
        }
    }
    
    @MainActor
    func dealCard() {
        model.drawCardsForCurrentPlayer(1, faceUp: true)
        playSound(.dealCard)
    }

    func chooseWildColor(_ color: Color) {
        switch color {
            case .red:
                model.wildColor = .red
            case .green:
                model.wildColor = .green
            case .yellow:
                model.wildColor = .yellow
            case .blue:
                model.wildColor = .blue
            default:
                model.wildColor = nil
        }
    }
    
    @MainActor
    func playSound(_ effect: SoundEffect) {
        SoundManager.shared.playSound(effect)
    }
    
}
