//
//  ContentView.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("New game") {
                    viewModel.resetGame()
                }
                Spacer()
                Button("Add cards") {
                    viewModel.addCards()
                }
                Spacer()
            }
            ZStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card).padding()
                }
            }
            ZStack {
                Text("Score: ")
            }
            .padding()
        }
        .padding(20)
    }
}

struct CardView: View {
    var card: SetGameModel<CardContent>.Card
    
    var cardElementsIdentifiable: [CardContentIdentifiable] {
        var cardElementsIdentifiable: [CardContentIdentifiable] = []
        for index in 0..<card.content.numberOFShapes {
            let cardElementIdentifiable = CardContentIdentifiable(cardContent: card.content, id: index)
            cardElementsIdentifiable.append(cardElementIdentifiable)
        }
        return cardElementsIdentifiable
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp && !card.isMatched {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                VStack {
                    ForEach(cardElementsIdentifiable) { element in
                        Text(element.shape.letter)
                    }
                }
                .font(Font.system(size: fontSize(for: size)))
                .opacity(card.content.shading)
            }
            .foregroundColor(card.content.color)
        }
    }
    
    //MARK: - Drawing contstants
    
    private let cornerRadius: CGFloat = 10.0
    private let lineWidth: CGFloat = 2.0
    private let fontScaleFactor: CGFloat = 0.3
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    
}

struct CardElementView: View {
    var cardElementIdentifiable: CardContentIdentifiable
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    body(for: geometry.size)
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        Text(cardElementIdentifiable.shape.letter)
    }
}

struct CardContentIdentifiable: Identifiable {
    var numberOFShapes: Int
//    var numberOFShapes: NumberOfShapes
    var shape: Shape
    var shading: Double
    var color: Color
    
    var id: Int
    
    init(cardContent: CardContent, id: Int) {
        numberOFShapes = cardContent.numberOFShapes
        shape = cardContent.shape
        shading = cardContent.shading
        color = cardContent.color
        
        self.id = id
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
