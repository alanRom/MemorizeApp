//
//  ContentView.swift
//  Memorize
//
//  Created by Alan Romano on 3/4/24.
//

import SwiftUI


struct EmojiMemoryGameView: View {
  
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            cards
                .foregroundColor(viewModel.getColor())
                .animation(.default, value: viewModel.cards)
                               
            Spacer()
            Button("Shuffle"){
                viewModel.shuffle()
            }
            
            Button("New Game"){
                viewModel.newGame()
            }
            
//            cardCountAdjusters
        }
       .padding()

    }
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        
    }
    
    
}



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
