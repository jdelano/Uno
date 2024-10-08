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
        if let card = deck.draw() {
            discardPile.add(card)
        }
    }
    
    mutating func initializeDeck() {
        for cardType in UnoCardType.allCases {
            for color in UnoCardColor.allCases {
                if (cardType.isWildCard && color != .wild) ||
                    (!cardType.isWildCard && color == .wild) { continue }
                for _ in 0..<cardType.countInDeck {
                    deck.add(Card(color: color, type: cardType))
                }
            }
        }
//        for color in UnoCardColor.allCases {
//            if color != .wild {
//                deck.add(Card(color: color, symbol: "0"))
//                for number in 1...9 {
//                    deck.add(Card(color: color, symbol: "\(number)"))
//                    deck.add(Card(color: color, symbol: "\(number)"))
//                }
//                
//                let specialCards = ["+2", " ⃠", "↺"]
//                for symbol in specialCards {
//                    deck.add(Card(color: color, symbol: symbol))
//                    deck.add(Card(color: color, symbol: symbol))
//                }
//            }
//        }
//        
//        for _ in 0..<4 {
//            deck.add(Card(color: .wild, symbol: "W"))
//            deck.add(Card(color: .wild, symbol: "+4"))
//        }
        print(deck.allItems.count)
        deck.shuffle()
    }
    
    mutating func dealCards() {
        // Add logic here
        for playerIndex in 0..<players.count {
            for _ in 0..<7 {
                if let card = deck.draw() {
                    players[playerIndex].hand.add(card)
                }
            }
        }
    }
    
    struct Player {
        private(set) var name: String
        fileprivate(set) var hand = Pile<Card>()
    }
    
    struct Card: Identifiable, Equatable, Playable {
        
        var id = UUID()
        
        let color: UnoCardColor
        let type: UnoCardType
        var symbol: String {
            type.symbol
        }
        
        fileprivate(set) var isFaceUp: Bool = true
    }
    
}


