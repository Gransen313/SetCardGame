//
//  ContentView.swift
//  SetCardGame
//
//  Created by Sergey Borisov on 24.02.2021.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var viewModel: SetGameViewModel
    
    private func deal(_ someCards: Int) {
        let delay: Double = someCards == numberOfCardsForStart ? delayForStart : noDelay
        withAnimation(Animation.easeOut(duration: durationConstant).delay(delay)) {
            viewModel.deal(someCards)
        }
    }
    
    private func getOffset() -> CGSize {
        let angle : Double = Double.random(in: 0...360)
        return CGSize(width: 1000 * cos(angle), height: 1000 * sin(angle))
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("New game") {
                    withAnimation(.easeOut(duration: durationConstant)) {
                        viewModel.resetGame()
                        deal(numberOfCardsForStart)
                    }
                }
                Spacer()
                Button("Deal 3 more cards") {
                    withAnimation(.easeInOut(duration: durationConstant)) {
                        viewModel.deal3MoreCardsPressed()
                    }
                }.disabled(viewModel.noMoreCards)
                Spacer()
            }
            ZStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.easeOut(duration: durationConstant)) {
                            viewModel.choose(card: card)
                        }
                    }
                    .transition(AnyTransition.offset(getOffset()))
                }
                .onAppear {
                    deal(numberOfCardsForStart)
                }
            }
            ZStack {
                Text("Score: \(viewModel.score)")
            }
            .padding()
        }
        .padding()
    }
    //MARK: - Constants
    private let numberOfCardsForStart: Int = 12
    private let delayForStart: Double = 1.0
    private let noDelay: Double = 0.0
    private let durationConstant: Double = 1.0
    
}

//MARK: - Card view
struct CardView: View {
    
    var card: SetGameModel.Card
    
    var cardContentIdentifiable: [CardContentIdentifiable] {
        var cardContentIdentifiable: [CardContentIdentifiable] = []
        for index in 0..<card.content.numberOfElements {
            let cardElementIdentifiable = CardContentIdentifiable(cardContent: card.content, id: index)
            cardContentIdentifiable.append(cardElementIdentifiable)
        }
        return cardContentIdentifiable
    }
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp && !card.isMatched {
            ZStack {
                RoundedRectangle(cornerRadius: size.width * cornerRadiusMultiplier)
                    .fill(card.isSelected ? Color.gray : Color.clear)
                    .opacity(opacityForSelection)
                RoundedRectangle(cornerRadius: size.width * cornerRadiusMultiplier)
                    .fill(colorForSet(card: card))
                    .opacity(opacityForSelection)
                RoundedRectangle(cornerRadius: size.width * cornerRadiusMultiplier)
                    .stroke(lineWidth: max(size.height * shadingWidthMultiplier, lineWidth))
                VStack(spacing: size.height * spacingMultiplier) {
                    ForEach(cardContentIdentifiable) { element in
                        card.content.figure.figure
                            .setShading(shading: card.content.shading, color: card.content.color, lineWidth: size.height * shadingWidthMultiplier)
//                            Make width and height dependent on the
//                            height of the container
                            .frame(width: size.height * elementWidthMultiplier, height: size.height * elementHeightMultiplier, alignment: .center)
                    }
                }
            }
//            Make frame of the visible card dependent on the height
//            of the container to keep ratio of the card and proportions
//            between size of the card and size of the inner elements
            .frame(width: size.height * bodyWidthMultiplier, height: size.height * bodyHeightMultiplier, alignment: .center)
            .foregroundColor(card.content.color)
        }
    }
    
    //MARK: - Drawing contstants
    
    private let cornerRadiusMultiplier: CGFloat = 0.1
    private let spacingMultiplier: CGFloat = 0.1
    private let shadingWidthMultiplier: CGFloat = 0.015
    
    private let lineWidth: CGFloat = 2.0
    private let fontScaleFactor: CGFloat = 0.3
    private let opacityForSelection: Double = 0.3
    private let scaleForStripes: CGFloat = 1.0
    
    private let bodyWidthMultiplier: CGFloat = 0.6
    private let bodyHeightMultiplier: CGFloat = 0.85
    private let elementWidthMultiplier: CGFloat = 0.4
    private let elementHeightMultiplier: CGFloat = 0.15
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    private func colorForSet(card: SetGameModel.Card) -> Color {
        if let isPartOfSet = card.isPartOfSet {
            return isPartOfSet ? .yellow : .red
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


