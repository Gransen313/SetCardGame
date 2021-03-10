//
//  SetGameModel.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

struct SetGameModel<Content> where Content: Equatable {
    
    private(set) var deck: Array<Card>
    private(set) var cardsOnTheTable: Array<Card>
    private(set) var numberOfFaceUpCards: Int = 12
    private(set) var lastFaceUpCardIndex: Int = 0
    
    init(deck: [Content], cardContantFactory: (Int) -> Content) {
        self.deck = Array<Card>()
        cardsOnTheTable = Array<Card>()
        for index in 0..<deck.count {
            let content = cardContantFactory(index)
            self.deck.append(Card(content: content, id: index))
        }
        self.deck.shuffle()
        faceUp(numberOfFaceUpCards)
    }
    
    mutating func faceUp(_ someCards: Int) {
        let upToIndex = min(lastFaceUpCardIndex + someCards, deck.count)
        for index in lastFaceUpCardIndex..<upToIndex {
            cardsOnTheTable.append(deck[index])
            cardsOnTheTable[index].isFaceUp = true
        }
        lastFaceUpCardIndex = upToIndex
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false
        var content: Content
        var id: Int
    }
    
}


