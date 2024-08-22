//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Alan Romano on 3/10/24.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        return MemoryGame(numberOfPairsOfCars: 2){ pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
            
        }
    }

    
    
    @Published private var model: MemoryGame<String>
    @Published private var theme: Theme
    
    init(){
        let startingTheme = Theme.chooseTheme(themeIndex: Int.random(in: 0..<Theme.SupportedThemes.count)) ?? Theme.defaultTheme
        theme = startingTheme
        model = EmojiMemoryGame.createMemoryGame(theme: startingTheme)
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        model.score
    }
    
    
    func getColor() -> Color {
        let color: Color
        switch theme.color {
            case "orange":
                color = Color.orange
            case "red":
                color = Color.red
            case "blue":
                color = Color.blue
            case "green":
                color = Color.green
            case "yellow":
                color = Color.yellow
            case "gray":
                color = Color.gray
            default:
                color = Color.black
        }
        return color
    }
    
    
    //MARK: - Intents
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    }
}
