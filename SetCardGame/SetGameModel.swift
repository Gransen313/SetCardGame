//
//  SetGameModel.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

struct SetGameModel {
//    Initial deck for game
    private(set) var deck: Array<Card> {
//        Set new values for cardsOnTheTable and selectedCards arrays
//        when deck changes
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
//            Check whether selected cards are matching a set or not if there're
//            three selected cards
            if selectedCards.count == maxNumberOfSelectedCards, !isDeckInProcess {
                selectMatching(cards: selectedCards)
            }
        }
    }
    private(set) var lastFaceUpCardIndex: Int
    private(set) var score: Int
//    Allows to change more than one card in deck without immediate change selectedCards
//    and cardsOnTheTable
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
//    Set isFaceUp value to true fore some cards in deck
    mutating func faceUp(_ someCards: Int) {
        isDeckInProcess = true
        let upToIndex = min(lastFaceUpCardIndex + someCards, deck.count)
        for index in lastFaceUpCardIndex..<upToIndex {
            deck[index].isFaceUp = true
        }
        lastFaceUpCardIndex = upToIndex
        isDeckInProcess = false
    }
//    Face up some cards if selected cards isn't matching a set
    mutating func deal3MoreCardsPressed() {
        selectedCards.count == maxNumberOfSelectedCards && checkMatching(cards: selectedCards) ? successfullSet(cards: selectedCards) : faceUp(maxNumberOfSelectedCards)
    }
//    Calls when user touch any card on the screen
    mutating func choose(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card), deck[choosenIndex].isFaceUp {
//            Check is it time to call checkMatching or not
            if selectedCards.count == maxNumberOfSelectedCards, !isDeckInProcess {
//                Call checkMatching and checkSelect if user touch not selected card
                if selectedCards.firstIndex(matching: card) == nil {
                    checkMatching(cards: selectedCards) ? successfullSet(cards: selectedCards) : deselectCards(cards: selectedCards)
                    checkSelect(card: card)
                } else {
//                    Call checkMatching only if user touch already selected card and
//                    also call checkSelect if selected cards aren't matching a set
                    if checkMatching(cards: selectedCards) {
                        successfullSet(cards: selectedCards)
                    } else {
                        deselectCards(cards: selectedCards)
                        checkSelect(card: card)
                    }
                }
            } else {
//                Call simply checkSelect if it isn't time to checking matching
                checkSelect(card: card)
            }
        }
    }
//    Check whether card is selected or not and
//    deselect it or select accordingly
    private mutating func checkSelect(card: Card) {
        if let index = deck.firstIndex(matching: card) {
            deck[index].isSelected ? deselectCard(card: deck[index]) : selectCard(card: deck[index])
        }
    }
//    Select not selected card in deck
    private mutating func selectCard(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card){
            deck[choosenIndex].isSelected = true
        }
    }
//    Deselect selected card in deck
    private mutating func deselectCard(card: Card) {
        if let choosenIndex = deck.firstIndex(matching: card) {
            deck[choosenIndex].isPartOfSet = nil
            deck[choosenIndex].isSelected = false
        }
    }
//    Deselect some quantity of selected cards
    private mutating func deselectCards(cards: [Card]) {
        isDeckInProcess = true
        cards.forEach { card in
            choose(card: card)
        }
        isDeckInProcess = false
    }
//    Swap the cards
    private mutating func replace(_ firstCard: Card, and secondCard: Card) {
        if let firstIndex = deck.firstIndex(matching: firstCard), let secondIndex = deck.firstIndex(matching: secondCard) {
            let secondCardTemporary: Card = deck.remove(at: secondIndex)
            let firstCardTemorary: Card = deck.remove(at: firstIndex)
            deck.insert(secondCardTemporary, at: firstIndex)
            deck.insert(firstCardTemorary, at: secondIndex)
        }
    }
//    Show when only three cards are selected and indicate whether they are
//    matching Set or not
    private mutating func selectMatching(cards: [Card]) {
        isDeckInProcess = true
        cards.forEach { card in
            if let index = deck.firstIndex(matching: card) {
                deck[index].isPartOfSet = checkMatching(cards: cards)
            }
        }
        isDeckInProcess = false
    }
//    Stop showing are the cards a part of set or not
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
//    Check are tree cards a part os set or not
    private mutating func checkMatching(cards: [Card]) -> Bool {
        compare(cards[0].content.color, cards[1].content.color, cards[2].content.color) &&
        compare(cards[0].content.numberOfElements, cards[1].content.numberOfElements, cards[2].content.numberOfElements) &&
        compare(cards[0].content.shading, cards[1].content.shading, cards[2].content.shading) &&
        compare(cards[0].content.figure, cards[1].content.figure, cards[2].content.figure)
    }
    
//    Check whether equatable parameters setted or not
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


