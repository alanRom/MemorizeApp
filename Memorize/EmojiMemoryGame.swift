//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alan Romano on 3/10/24.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    
    private static let emojis = ["👻", "🎃", "😈", "🕷️", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭" ]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCars: 10){ pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
            
        }
    }
    
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
}
