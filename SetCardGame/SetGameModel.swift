//
//  SetGameModel.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

struct SetGameModel {
    
    private(set) var deck: Array<Card>
    private(set) var cardsOnTheTable: Array<Card>
    private(set) var selectedCards: Array<Card> {
        didSet {
            if selectedCards.count == maxNumberOfSelectedCards {
                checkMatching(cards: selectedCards)
            }
        }
    }
    
    private(set) var lastFaceUpCardIndex: Int
    
    init(deck: [CardContent], cardContantFactory: (Int) -> CardContent) {
        self.deck = Array<Card>()
        cardsOnTheTable = Array<Card>()
        selectedCards = Array<Card>()
        
        lastFaceUpCardIndex = initialLastFaceUpCardIndex
        
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
            cardsOnTheTable.append(deck[index])
            cardsOnTheTable[index].isFaceUp = true
        }
        lastFaceUpCardIndex = upToIndex
    }
    
    mutating func choose(card: Card) {
        if let choosenIndex = cardsOnTheTable.firstIndex(matching: card){
            cardsOnTheTable[choosenIndex].isSelected ? deselectCard(card: cardsOnTheTable[choosenIndex]) : selectCard(card: cardsOnTheTable[choosenIndex])
        }
    }
    
    mutating func selectCard(card: Card) {
        if let choosenIndex = cardsOnTheTable.firstIndex(matching: card){
            cardsOnTheTable[choosenIndex].isSelected = true
            selectedCards.append(cardsOnTheTable[choosenIndex])
        }
    }
    
    mutating func deselectCard(card: Card) {
        guard let choosenIndexForCardsOnTheTable = cardsOnTheTable.firstIndex(matching: card) else { return }
        cardsOnTheTable[choosenIndexForCardsOnTheTable].isSelected = false
        
        guard let choosenIndexForSelectedCards = selectedCards.firstIndex(matching: card) else { return }
        selectedCards.remove(at: choosenIndexForSelectedCards)
    }
    
    mutating func deselectAllCards() {
        selectedCards.forEach { card in
            if let choosenIndex = cardsOnTheTable.firstIndex(matching: card){
                cardsOnTheTable[choosenIndex].isSelected = false
            }
            selectedCards.removeAll()
        }
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
//
    mutating func checkMatching(cards: [Card]) {
        matched(first: cards[0].content, second: cards[1].content, third: cards[2].content) ? successfullSet() : deselectAllCards()
    }
    
    func successfullSet() {
        print("SET!!!")
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
    
}


