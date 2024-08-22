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
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card)
                .padding(4)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
        
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
    
    
}



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
