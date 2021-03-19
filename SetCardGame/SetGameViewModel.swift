//
//  SetGameViewModel.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import Foundation

class SetGameViewModel: ObservableObject {
    
    @Published private var model: SetGameModel = SetGameViewModel.createSetGameModel()
    
    private static func createSetGameModel() -> SetGameModel {
        let deck = Deck().deck
        return SetGameModel(deck: deck) { index in deck[index] }
    }
    
    //MARK: - Access to model
    var cards: Array<SetGameModel.Card> {
        model.cardsOnTheTable
    }
    var score: Int {
        model.score
    }
    var noMoreCards: Bool {
        model.lastFaceUpCardIndex == model.deck.count
    }
    
    //MARK: - Intent(s)
    func resetGame() {
        model = SetGameViewModel.createSetGameModel()
    }
    func deal3MoreCardsPressed() {
        model.deal3MoreCardsPressed()
    }
    func choose(card: SetGameModel.Card) {
        model.choose(card: card)
    }
    
    //MARK: - Constants
    private let numberOfCardsToAdd = 3
    
}
