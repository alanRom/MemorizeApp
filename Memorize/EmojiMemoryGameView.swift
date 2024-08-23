//
//  ContentView.swift
//  Memorize
//
//  Created by Alan Romano on 3/4/24.
//

import SwiftUI


struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            cards
                .foregroundColor(viewModel.getColor())
                               
            Spacer()
            HStack {
                score
                Spacer()
                shuffle
                
                
            }
            
            
//            cardCountAdjusters
        }
       .padding()

    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle"){
            withAnimation{
                viewModel.shuffle()
            }
        }
    }
    
    private var newGame: some View {
        Button("New Game"){
            viewModel.newGame()
        }
    }
    
    @State private var lastScoreChange: (amount: Int, causedByCardId: Card.ID) = ( 0, causedByCardId: "")
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card)
                .padding(4)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                .onTapGesture {
                    withAnimation {
                        let scoreBeforeChoosing = viewModel.score
                        viewModel.choose(card)
                        
                        let scoreChange = viewModel.score - scoreBeforeChoosing
                        lastScoreChange = (scoreChange, causedByCardId: card.id)
                    }
                }
        }
        
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
        
    }
    
    
}



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
