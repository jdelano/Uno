//
//  UnoCardType.swift
//  Uno
//
//  Created by John Delano on 9/28/24.
//

import Foundation

enum UnoCardType: CaseIterable, Equatable, Hashable, Codable {
    static var allCases: [UnoCardType] {
        [.face(0), .face(1), .face(2), .face(3), .face(4), .face(5), .face(6), .face(7), .face(8), .face(9), .drawTwo, .skip, .reverse, .wild, .drawFour]
    }
    
    case face(Int)
    case reverse
    case skip
    case drawTwo
    case wild
    case drawFour
    
    var symbol: String {
        switch self {
            case .drawTwo: return "+2"
            case .drawFour: return "+4"
            case .wild: return "W"
            case .reverse: return "↺"
            case .skip: return " ⃠"
            case .face(let value): return "\(value)"
        }
    }
    
    var points: Int {
        switch self {
            case .face(let value): return value
            case .drawTwo, .skip, .reverse: return 20
            case .wild, .drawFour: return 50
        }
    }
    
    var countInDeck: Int {
        switch self {
            case .face(let value):
                return value == 0 ? 1 : 2
            case .drawTwo, .skip, .reverse: return 2
            case .wild, .drawFour: return 4
        }
    }
    
    var isWildCard: Bool {
        switch self {
            case .wild, .drawFour: return true
            default: return false
        }
    }
    
}
