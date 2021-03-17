//
//  SetGameModel.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

struct SetGameModel {
    
    private(set) var deck: Array<Card> {
        didSet {
            var cardsOnTheTableTemporary = [Card]()
            var selectedCardsTemporary = [Card]()
            deck.forEach { card in
                if card.isFaceUp {
                    cardsOnTheTableTemporary.append(card)
                    if card.isSelected {
                        selectedCardsTemporary.append(card)
                    }
                }
            }
            cardsOnTheTable = cardsOnTheTableTemporary
            selectedCards = selectedCardsTemporary
        }
    }
    private(set) var cardsOnTheTable: Array<Card>
    private(set) var selectedCards: Array<Card> {
        willSet {
            if selectedCards.count == maxNumberOfSelectedCards, isNecessaryCheckMatching {
                print("selected cards: \(selectedCards.count)")
                checkMatching(cards: selectedCards)
            }
        }
    }
    private(set) var isNecessaryCheckMatching: Bool = true
    
    private(set) var lastFaceUpCardIndex: Int
    private(set) var score: Int
    
    init(deck: [CardContent], cardContantFactory: (Int) -> CardContent) {
        self.deck = Array<Card>()
        cardsOnTheTable = Array<Card>()
        selectedCards = Array<Card>()
        
        lastFaceUpCardIndex = initialLastFaceUpCardIndex
        score = initialScore
        
        for index in 0..<deck.count {
            let content = cardContantFactory(index)
            self.deck.append(Card(content: content, id: index))
        }
        self.deck.shuffle()
        faceUp(numberOfCardsForStart)
    }
    
    mutating func faceUp(_ someCards: Int) {
        let upToIndex = min(lastFaceUpCardIndex + someCards, deck.count)
        for index in lastFaceUpCardIndex..<upToIndex {
            deck[index].isFaceUp = true
        }
        lastFaceUpCardIndex = upToIndex
    }
    
    mutating func choose(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card){
            deck[choosenIndex].isSelected ? deselectCard(card: deck[choosenIndex]) : selectCard(card: deck[choosenIndex])
        }
    }
    
    mutating func selectCard(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card){
            deck[choosenIndex].isSelected = true
        }
    }
    
    mutating func deselectCard(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card) {
            if deck[choosenIndex].isFaceUp, deck[choosenIndex].isSelected {
                deck[choosenIndex].isSelected = false
            }
        }
    }
    
    mutating func deselectCards(cards: [Card]) {
        print("deselect all is called")
        cards.forEach { card in
            if let index = deck.firstIndex(matching: card) {
                deck[index].isSelected = false
            }
        }
    }
    
    mutating func successfullSet(cards: [Card]) {
        print("successfull set is called")
        score += 3
        cards.forEach { card in
            if let index = deck.firstIndex(matching: card) {
                deck[index].isSelected = false
                deck[index].isFaceUp = false
            }
        }
    }

    mutating func checkMatching(cards: [Card]) {
        print("check matching is called")
        isNecessaryCheckMatching = false
        if matched(cards[0].content.color, cards[1].content.color, cards[2].content.color),
           matched(cards[0].content.numberOFShapes, cards[1].content.numberOFShapes, cards[2].content.numberOFShapes),
           matched(cards[0].content.shading, cards[1].content.shading, cards[2].content.shading),
           matched(cards[0].content.shape, cards[1].content.shape, cards[2].content.shape)
        {
            successfullSet(cards: cards)
        } else {
            deselectCards(cards: cards)
        }
        isNecessaryCheckMatching = true
    }
    
    //Check whether equatable parameters setted or not
    func matched<P: Equatable>(_ first: P, _ second: P, _ third: P) -> Bool {
        ((first == second) && (second == third)) || ((first != second) && (first != third) && (second != third))
    }
    
    //MARK: - Card structure
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
    //MARK: - Constants
    private let numberOfCardsForStart: Int = 12
    private let initialLastFaceUpCardIndex: Int = 0
    private let maxNumberOfSelectedCards: Int = 3
    private let initialScore: Int = 0
    
}


