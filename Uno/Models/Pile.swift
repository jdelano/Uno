//
//  Pile.swift
//  Uno
//
//  Created by John Delano on 9/25/24.
//

import Foundation

struct Pile<T> {
    private var items: [T] = []
    
    mutating func add(_ item: T) {
        items.append(item)
    }
    
    mutating func draw() -> T {
        items.popLast()! // HACK: Need to fix this
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
}
