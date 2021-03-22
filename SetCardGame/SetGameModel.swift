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
        didSet {
            if selectedCards.count == maxNumberOfSelectedCards, !isDeckInProcess {
                selectMatching(cards: selectedCards)
            }
        }
    }
    private(set) var lastFaceUpCardIndex: Int
    private(set) var score: Int
    
    private var isDeckInProcess: Bool = false
    private var isDeckOver: Bool {
        lastFaceUpCardIndex == deck.count
    }
    
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
        isDeckInProcess = true
        let upToIndex = min(lastFaceUpCardIndex + someCards, deck.count)
        for index in lastFaceUpCardIndex..<upToIndex {
            deck[index].isFaceUp = true
        }
        lastFaceUpCardIndex = upToIndex
        isDeckInProcess = false
    }
    
    mutating func deal3MoreCardsPressed() {
        selectedCards.count == maxNumberOfSelectedCards && checkMatching(cards: selectedCards) ? successfullSet(cards: selectedCards) : faceUp(maxNumberOfSelectedCards)
    }
    
    mutating func choose(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card), deck[choosenIndex].isFaceUp {
            if selectedCards.count == maxNumberOfSelectedCards, !isDeckInProcess {
                checkMatching(cards: selectedCards) ? successfullSet(cards: selectedCards) : deselectCards(cards: selectedCards)
            }
            deck[choosenIndex].isSelected ? deselectCard(card: deck[choosenIndex]) : selectCard(card: deck[choosenIndex])
        }
    }
    
    private mutating func selectCard(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card){
            deck[choosenIndex].isSelected = true
        }
    }
    
    private mutating func deselectCard(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card) {
            deck[choosenIndex].isPartOfSet = nil
            deck[choosenIndex].isSelected = false
        }
    }
    
    private mutating func deselectCards(cards: [Card]) {
        isDeckInProcess = true
        cards.forEach { card in
            choose(card: card)
        }
        isDeckInProcess = false
    }
    
    private mutating func replace(_ firstCard: Card, and secondCard: Card) {
        if let firstIndex = deck.firstIndex(matching: firstCard), let secondIndex = deck.firstIndex(matching: secondCard) {
            let secondCardTemporary: Card = deck.remove(at: secondIndex)
            let firstCardTemorary: Card = deck.remove(at: firstIndex)
            deck.insert(secondCardTemporary, at: firstIndex)
            deck.insert(firstCardTemorary, at: secondIndex)
        }
    }
    
    // Show when only three cards are selected and indicate whether they are
    // matching Set or not
    private mutating func selectMatching(cards: [Card]) {
        isDeckInProcess = true
        cards.forEach { card in
            if let index = deck.firstIndex(matching: card) {
                deck[index].isPartOfSet = checkMatching(cards: cards)
            }
        }
        isDeckInProcess = false
    }
    
    private mutating func deselectMatching(cards: [Card]) {
        isDeckInProcess = true
        cards.forEach { card in
            if let index = deck.firstIndex(matching: card) {
                deck[index].isPartOfSet = nil
            }
        }
        isDeckInProcess = false
    }
    
    private mutating func successfullSet(cards: [Card]) {
        score += 3
        isDeckInProcess = true
        cards.forEach { card in
            if !isDeckOver {
                faceUp(numberOfCardsForReplace)
                if let last = cardsOnTheTable.last {
                    replace(card, and: last)
                }
            }
            if let index = deck.firstIndex(matching: card) {
                deck[index].isMatched = true
                deck[index].isFaceUp = false
                deck[index].isSelected = false
            }
        }
        isDeckInProcess = false
    }
    
    private mutating func checkMatching(cards: [Card]) -> Bool {
        compare(cards[0].content.color, cards[1].content.color, cards[2].content.color) &&
        compare(cards[0].content.numberOfElements, cards[1].content.numberOfElements, cards[2].content.numberOfElements) &&
        compare(cards[0].content.shading, cards[1].content.shading, cards[2].content.shading) &&
        compare(cards[0].content.figure, cards[1].content.figure, cards[2].content.figure)
    }
    
    //Check whether equatable parameters setted or not
    private func compare<P: Equatable>(_ first: P, _ second: P, _ third: P) -> Bool {
        ((first == second) && (second == third)) || ((first != second) && (first != third) && (second != third))
    }
    
    //MARK: - Card structure
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var isPartOfSet: Bool?
        
        var id: Int
    }
    
    //MARK: - Constants
    private let numberOfCardsForStart: Int = 12
    private let numberOfCardsForReplace: Int = 1
    private let initialLastFaceUpCardIndex: Int = 0
    private let maxNumberOfSelectedCards: Int = 3
    private let initialScore: Int = 0
    
}


