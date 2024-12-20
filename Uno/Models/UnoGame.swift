//
//  UnoGame.swift
//  Uno
//
//  Created by John Delano on 9/18/24.
//

import Foundation

struct UnoGame : Codable {
    private(set) var players: [Player]
    private(set) var deck = Pile<Card>()
    private(set) var discardPile = Pile<Card>()
    private var isReversed: Bool = false
    // Optional property to store the selected color for Wild and Draw Four cards
    var wildColor: UnoCardColor?

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
    
    var topDiscardCard: Card? {
        var card = discardPile.topItem
        card?.isFaceUp = true
        return card
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
        isReversed = false
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
        currentPlayerIndex += isReversed ?  -1 : 1
    }
    
    mutating func reverseDirection() {
        isReversed.toggle()
    }
    

    mutating func reshuffleDeckIfNeeded() {
        if deck.isEmpty, discardPile.allItems.count > 1 {
            let cardsToReshuffle = discardPile.allItems.dropLast()
            deck.add(contentsOf: Array(cardsToReshuffle))
            deck.shuffle()
            discardPile.reset(keepingLast: true)
        }
    }

    // Draws a specific number of cards for the current player
    mutating func drawCardsForCurrentPlayer(_ count: Int, faceUp: Bool = false) {
        if deck.allItems.count < count {
            reshuffleDeckIfNeeded() // Ensure we have enough cards by reshuffling if needed
        }
        var cards = deck.draw(count)
        // Set faceup status
        for index in 0..<cards.count {
            cards[index].isFaceUp = faceUp
        }
        players[currentPlayerIndex].drawCards(cards)
    }
    
    mutating func playCard(_ card: Card) {
        if let topDiscardCard = discardPile.topItem,
           card.canPlay(on: topDiscardCard, wildColor: wildColor),
           let card = players[currentPlayerIndex].hand.playItem(card) {
            discardPile.add(card)
            
            // Handle special card effects
            switch card.type {
                case .reverse:
                    reverseDirection()
                    nextPlayer()
                case .skip:
                    nextPlayer() // Skip the next player
                    nextPlayer()
                case .drawTwo:
                    nextPlayer()
                    players[currentPlayerIndex].drawCards(deck.draw(2))
                    nextPlayer()
                case .wild:
                    nextPlayer()
                case .drawFour:
                    nextPlayer()
                    players[currentPlayerIndex].drawCards(deck.draw(4))
                    nextPlayer()
                default:
                    nextPlayer()
            }
            if !card.type.isWildCard {
                wildColor = nil
            }
        }
    }
    
    var playerNames: [String] {
        get { players.map { $0.name } }
        set {
            for index in 0..<newValue.count {
                players[index].name = newValue[index]
            }
        }
    }
    
    struct Player: Codable {
        fileprivate(set) var name: String
        fileprivate(set) var hand = Pile<Card>()
        
        mutating func drawCard(_ card: Card) {
            hand.add(card)
        }
        
        mutating func drawCards(_ cards: [Card]) {
            hand.add(contentsOf: cards)
        }
    }
    
    struct Card: Identifiable, Equatable, Playable, Hashable, Codable {
        var id = UUID()
        
        let color: UnoCardColor
        let type: UnoCardType
        var symbol: String {
            type.symbol
        }
        
        var isFaceUp: Bool = false
    }
    
}


