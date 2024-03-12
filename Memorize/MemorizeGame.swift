//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Alan Romano on 3/10/24.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCars: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        // add numberOfPairsOfCars * 2
        for pairIndex in 0..<max(numberOfPairsOfCars, 2) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
