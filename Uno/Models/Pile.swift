//
//  Pile.swift
//  Uno
//
//  Created by John Delano on 9/25/24.
//

import Foundation

struct Pile<T> where T: Playable {
    private var items: [T] = []
    
    mutating func add(_ item: T) {
        items.append(item)
    }
    
    mutating func draw() -> T? {
        items.popLast()
    }
    
    mutating func shuffle() {
        items.shuffle()
    }
    
    mutating func reset() {
        items.removeAll()
    }
    
    var allItems: [T] {
        items
    }
    
    mutating func flipItems(isFaceUp: Bool) {
        for index in items.indices {
            items[index].isFaceUp = isFaceUp
        }
    }
}
