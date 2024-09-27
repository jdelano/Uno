//
//  UnoGame.swift
//  Uno
//
//  Created by John Delano on 9/18/24.
//

import Foundation

struct UnoGame {
    private(set) var players: [Player]
    private(set) var deck = Pile<Card>()
    private(set) var discardPile = Pile<Card>()
    private(set) var currentPlayerIndex: Int = 0
    
    init(players: [String]) {
        self.players = players.map { Player(name: $0) }
        resetGame()
    }
    
    mutating func resetGame() {
        for playerIndex in 0..<players.count {
            players[playerIndex].hand.reset()
        }
        deck.reset()
        discardPile.reset()
        initializeDeck()
        dealCards()
        discardPile.add(deck.draw())
    }
    
    mutating func initializeDeck() {
        for color in UnoCardColor.allCases {
            if color != .wild {
                deck.add(Card(color: color, symbol: "0"))
                for number in 1...9 {
                    deck.add(Card(color: color, symbol: "\(number)"))
                    deck.add(Card(color: color, symbol: "\(number)"))
                }
                
                let specialCards = ["+2", " ⃠", "↺"]
                for symbol in specialCards {
                    deck.add(Card(color: color, symbol: symbol))
                    deck.add(Card(color: color, symbol: symbol))
                }
            }
        }
        
        for _ in 0..<4 {
            deck.add(Card(color: .wild, symbol: "W"))
            deck.add(Card(color: .wild, symbol: "+4"))
        }
        deck.shuffle()
    }
    
    mutating func dealCards() {
        // Add logic here
        for playerIndex in 0..<players.count {
            for _ in 0..<7 {
                players[playerIndex].hand.add(deck.draw())
            }
        }
    }
    
    struct Player {
        private(set) var name: String
        fileprivate(set) var hand = Pile<Card>()
    }
    
    struct Card: Identifiable {
        var id = UUID()
        
        let color: UnoCardColor
        let symbol: String
        fileprivate(set) var isFaceUp: Bool = true
    }
    
}


