//
//  Deck.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

struct Deck {
    
    // An abstract deck of playing cards, not in game in current moment
    var deck = Array<CardContent>()
    
    static let numberOfShapes: [Int] = [1, 2, 3]
//    static let numberOfShapes: [NumberOfShapes] = [NumberOfShapes.one, NumberOfShapes.two, NumberOfShapes.three]
    static let shapes: [Shape] = [.diamond, .rectangle, .oval]
    static let shadings: [Double] = [0.33, 0.66, 1.0]
    static let colors: [Color] = [.green, .pink, .orange]
    
    init() {
        deck = createDeck()
    }
    
    mutating func createDeck() -> Array<CardContent> {
        var deck = Array<CardContent>()
        for number in Deck.numberOfShapes {
            for shape in Deck.shapes {
                for shading in Deck.shadings {
                    for color in Deck.colors {
                        let card = CardContent(numberOFShapes: number, shape: shape, shading: shading, color: color)
                        deck.append(card)
                    }
                }
            }
        }
        return deck
    }
    
    func cardsIsMatched() {
        
    }
    
    func matched<P: Equatable>(first: P, second: P, third: P) -> Bool {
        if ((first == second) && (second == third)) || ((first != second) && (first != third) && (second != third)) {
            print("matched")
            return true
        } else {
            print("not matched")
            return false
        }
    }
    
}

struct CardContent: Equatable {
    
    var numberOFShapes: Int
//    var numberOFShapes: NumberOfShapes
    var shape: Shape
    var shading: Double
    var color: Color
    
}

enum Shape: Equatable {
    case diamond, rectangle, oval
    var letter: String {
        switch self {
        case .diamond: return "D"
        case .oval: return "O"
        case .rectangle: return "R"
        }
    }
}

enum NumberOfShapes {
    case one, two, three
}
