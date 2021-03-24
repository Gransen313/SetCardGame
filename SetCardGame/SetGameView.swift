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
                    withAnimation(.easeInOut) {
                        viewModel.resetGame()
                    }
                }
                Spacer()
                Button("Deal 3 more cards") {
                    withAnimation(.easeInOut) {
                        viewModel.deal3MoreCardsPressed()
                    }
                }.disabled(viewModel.noMoreCards)
                Spacer()
            }
            ZStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card)
                        .padding()
                        .onTapGesture {
                            withAnimation(.linear) {
                                viewModel.choose(card: card)
                            }
                        }
                }
            }
            ZStack {
                Text("Score: \(viewModel.score)")
            }
            .padding()
        }
        .padding()
    }
    
}

//MARK: - Card view
struct CardView: View {
    
    var card: SetGameModel.Card
    
    var cardElementsIdentifiable: [CardContentIdentifiable] {
        var cardElementsIdentifiable: [CardContentIdentifiable] = []
        for index in 0..<card.content.numberOfElements {
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
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(card.isSelected ? Color.gray : Color.white)
                    .opacity(opacityForSelection)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(colorForSet(card: card))
                    .opacity(opacityForSelection)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: lineWidth)
                VStack(spacing: spacingDistance) {
                    ForEach(cardElementsIdentifiable) { element in
                        card.content.figure.figure
                            .setShading(shading: card.content.shading, color: card.content.color, lineWidth: lineWidth)
                            .frame(width: size.width * elementWidthMultiplier, height: size.height * elementHeightMultiplier, alignment: .center)
                    }
                }
            }
            .frame(width: size.width * cardWidthMultiplier, height: size.height * cardHeightMultiplier, alignment: .center)
            .foregroundColor(card.content.color)
        }
    }
    
    //MARK: - Drawing contstants
    
    private let cornerRadius: CGFloat = 10.0
    private let lineWidth: CGFloat = 2.0
    private let fontScaleFactor: CGFloat = 0.3
    private let opacityForSelection: Double = 0.3
    private let spacingDistance: CGFloat = 5.0
    private let scaleForStripes: CGFloat = 1.0
    
    private let elementWidthMultiplier: CGFloat = 0.5
    private let elementHeightMultiplier: CGFloat = 0.2
    private let cardWidthMultiplier: CGFloat = 1.1
    private let cardHeightMultiplier: CGFloat = 1.1
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    private func colorForSet(card: SetGameModel.Card) -> Color {
        if let isPartOfSet = card.isPartOfSet {
            return isPartOfSet ? .yellow : .blue
        } else {
            return .clear
        }
    }
    
}

//MARK: - Struct for drawing one element of card content
struct CardContentIdentifiable: Identifiable {
    
    var figure: Figure
    var shading: Shading
    var color: Color
    
    var id: Int
    
    init(cardContent: CardContent, id: Int) {
        figure = cardContent.figure
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


