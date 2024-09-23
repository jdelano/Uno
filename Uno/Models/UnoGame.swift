//
//  UnoGame.swift
//  Uno
//
//  Created by John Delano on 9/18/24.
//

import Foundation

struct UnoGame {
    private(set) var players: [Player]
    private(set) var deck: [Card] = []
    private(set) var discardPile: [Card] = []
    private(set) var currentPlayerIndex: Int = 0
    
    init(players: [String]) {
        self.players = players.map { Player(name: $0) }
        resetGame()
    }
    
    mutating func resetGame() {
        for playerIndex in 0..<players.count {
            players[playerIndex].hand.removeAll()
        }
        deck.removeAll()
        discardPile.removeAll()
        initializeDeck()
        dealCards()
        discardPile.append(deck.popLast()!)
    }
    
    mutating func initializeDeck() {
        let colors = ["Red", "Green", "Blue", "Yellow"]
        for color in colors {
            deck.append(Card(color: color, symbol: "0"))
            for number in 1...9 {
                deck.append(Card(color: color, symbol: "\(number)"))
                deck.append(Card(color: color, symbol: "\(number)"))
            }
            
            let specialCards = ["+2", " ⃠", "↺"]
            for symbol in specialCards {
                deck.append(Card(color: color, symbol: symbol))
                deck.append(Card(color: color, symbol: symbol))
            }
        }
        
        for _ in 0..<4 {
            deck.append(Card(color: "Black", symbol: "W"))
            deck.append(Card(color: "Black", symbol: "+4"))
        }
        deck.shuffle()
    }
    
    mutating func dealCards() {
        // Add logic here
        for playerIndex in 0..<players.count {
            for _ in 0..<7 {
                players[playerIndex].hand.append(deck.popLast()!)
            }
        }
    }
    
    struct Player {
        private(set) var name: String
        fileprivate(set) var hand: [Card] = []
    }
    
    struct Card {
        let color: String
        let symbol: String
        fileprivate(set) var isFaceUp: Bool = true
    }
    
}


