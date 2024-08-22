//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Alan Romano on 3/10/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    
    init(numberOfPairsOfCars: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        for pairIndex in 0..<max(numberOfPairsOfCars, 2) {
            let content = cardContentFactory(pairIndex)
            self.cards .append(Card(content: content, id: "\(pairIndex+1)a"))
            self.cards .append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        self.cards .shuffle()
        self.score = 0
    }
        
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex =  cards.firstIndex(where: { $0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                
                cards[chosenIndex].isFaceUp = true
            }
            
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    

    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
        
        var id: String
    }
}



extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
