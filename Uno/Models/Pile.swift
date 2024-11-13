//
//  Pile.swift
//  Uno
//
//  Created by John Delano on 9/25/24.
//

import Foundation

struct Pile<T> : Codable where T: Playable, T: Identifiable, T: Codable {
    private var items: [T] = []
    
    mutating func add(_ item: T) {
        items.append(item)
    }
    
    mutating func add(contentsOf items: [T]) {
        self.items.append(contentsOf: items)
    }
    
    mutating func draw() -> T? {
        items.popLast()
    }
    
    mutating func draw(_ count: Int) -> [T] {
        let drawnItems = items.suffix(count)
        items.removeLast(count)
        return Array(drawnItems)
    }
    
    mutating func shuffle() {
        items.shuffle()
    }
    
    mutating func reset(keepingLast: Bool = false) {
        if keepingLast, let lastItem = items.last {
            items = [lastItem]
        } else {
            items.removeAll()
        }
    }
    
    var allItems: [T] {
        items
    }
    
    var topItem: T? {
        items.last
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    mutating func playItem(_ item: T) -> T? {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            return items.remove(at: index)
        } else {
            return nil
        }
    }
    
    mutating func flipItems(isFaceUp: Bool) {
        for index in items.indices {
            items[index].isFaceUp = isFaceUp
        }
    }
}
