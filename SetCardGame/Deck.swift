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
    static let numberOfElements: [Int] = [1, 2, 3]
//    static let numberOfShapes: [NumberOfShapes] = [NumberOfShapes.one, NumberOfShapes.two, NumberOfShapes.three]
    static let figures: [Figure] = [.diamond, .rectangle, .oval]
    static let shadings: [Shading] = [.solid, .striped, .open]
    static let colors: [Color] = [.green, .pink, .orange]
    
    init() {
        deck = createDeck()
    }
    
    mutating func createDeck() -> Array<CardContent> {
        var deck = Array<CardContent>()
        Deck.numberOfElements.forEach { number in
            Deck.figures.forEach { figure in
                Deck.shadings.forEach { shading in
                    Deck.colors.forEach { color in
                        let card = CardContent(numberOfElements: number, figure: figure, shading: shading, color: color)
                        deck.append(card)
                    }
                }
            }
        }
        return deck
    }
    
}

struct CardContent: Equatable {
    
    var numberOfElements: Int
//    var numberOFShapes: NumberOfShapes
    var figure: Figure
//    var shading: Double
    var shading: Shading
    var color: Color
    
}

enum Figure: Equatable {
    case diamond, rectangle, oval
    
    var letter: String {
        switch self {
        case .diamond: return "D"
        case .oval: return "O"
        case .rectangle: return "R"
        }
    }
    var figure: some Shape {
        switch self {
        case .diamond: return AnyShape(shape: Rectangle())
        case .oval: return AnyShape(shape: RoundedRectangle(cornerRadius: 12))
        case .rectangle: return AnyShape(shape: Ellipse())
        }
    }
}

enum Shading: Equatable {
    case solid, striped, open
}

enum NumberOfShapes {
    case one, two, three
}
