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
    
    private var _currentPlayerIndex: Int = 0 {
        didSet {
            for playerIndex in players.indices {
                players[playerIndex].hand.flipItems(isFaceUp: playerIndex == _currentPlayerIndex)
            }
        }
    }
    
    private(set) var currentPlayerIndex: Int
    {
        get { _currentPlayerIndex }
        set {
            _currentPlayerIndex = (newValue % players.count + players.count) % players.count
        }
    }
    
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
        currentPlayerIndex = 0
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
    
    mutating func nextPlayer() {
        currentPlayerIndex += 1
    }
    
    mutating func reversePlayer() {
        currentPlayerIndex -= 1
    }
    
    struct Player {
        private(set) var name: String
        fileprivate(set) var hand = Pile<Card>()
    }
    
    struct Card: Identifiable, Equatable, Playable, Hashable {
        
        var id = UUID()
        
        let color: UnoCardColor
        let type: UnoCardType
        var symbol: String {
            type.symbol
        }
        
        var isFaceUp: Bool = false
    }
    
}


