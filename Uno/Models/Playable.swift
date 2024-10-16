//
//  Playable.swift
//  Uno
//
//  Created by John Delano on 10/7/24.
//

protocol Playable {
    var color: UnoCardColor { get }
    var type: UnoCardType { get }
    var isFaceUp: Bool { get set }
    func canPlay(on topCard: Playable) -> Bool
}

extension Playable {
    func canPlay(on topCard: Playable) -> Bool {
        self.color == topCard.color ||
        self.type == topCard.type ||
        self.type.isWildCard
    }
    
    static func canPlay(_ cards: [any Playable], on topCard: any Playable) -> [any Playable] {
        cards.filter { $0.canPlay(on: topCard) }
    }
}
