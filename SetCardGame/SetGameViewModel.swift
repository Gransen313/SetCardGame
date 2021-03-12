//
//  SetGameViewModel.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import Foundation

class SetGameViewModel: ObservableObject {
    
    @Published private var model: SetGameModel<CardContent> = SetGameViewModel.createSetGameModel()
    
    private static func createSetGameModel() -> SetGameModel<CardContent> {
        let deck = Deck().deck
        return SetGameModel<CardContent>(deck: deck) { index in deck[index] }
    }
    
    //MARK: - Access to model
    var cards: Array<SetGameModel<CardContent>.Card> {
        model.cardsOnTheTable
    }
    
    //MARK: - Intent(s)
    func resetGame() {
        model = SetGameViewModel.createSetGameModel()
    }
    func addCards() {
        model.faceUp(numberOfCardsToAdd)
    }
    func choose(card: SetGameModel<CardContent>.Card) {
        model.choose(card: card)
    }
    
    //MARK: - Constants
    private let numberOfCardsToAdd = 3
    
}
