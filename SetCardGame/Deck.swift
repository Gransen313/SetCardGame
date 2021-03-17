//
//  Deck.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

struct Deck {
    
    // An abstract deck of playing cards
    var deck = Array<CardContent>()
    
    // All possible variants of cards parameters
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
        Deck.numberOfShapes.forEach { number in
            Deck.shapes.forEach { shape in
                Deck.shadings.forEach { shading in
                    Deck.colors.forEach { color in
                        let card = CardContent(numberOFShapes: number, shape: shape, shading: shading, color: color)
                        deck.append(card)
                    }
                }
            }
        }
        return deck
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
