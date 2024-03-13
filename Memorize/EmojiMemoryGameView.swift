//
//  ContentView.swift
//  Memorize
//
//  Created by Alan Romano on 3/4/24.
//

import SwiftUI

enum Themes {
    case None, Halloween, Food, Animals
}



struct EmojiMemoryGameView: View {
    private let halloweenEmojis = ["👻", "🎃", "😈", "🕷️", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭" ]
    private let foodEmojis = ["🍎", "🍒", "🍋", "🫒", "🍕", "🍟", "🥞", "🥐", "🫔", "🌮", "🍰", "🍙" ]
    private let animalEmojis = ["🐥", "🐴", "🐝", "🕷️", "🐟", "🦑", "🐱", "🐶", "🐻‍❄️", "🦆", "🦊", "🐓" ]
    
   @ObservedObject var viewModel: EmojiMemoryGame
    
    
    @State var activeTheme: Themes = Themes.None
    
    @State var cardCount = 0
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("Shuffle"){
                viewModel.shuffle()
            }
//            cardCountAdjusters
            themeChoosers
        }
       .padding()

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio(2/3, contentMode:.fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
    
//    var cardCountAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//            
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
    
    var themeChoosers: some View {
        HStack{
            halloweenThemeButton
            foodThemeButton
            animalThemeButton
        }
    }
    
    
    var halloweenThemeButton: some View {
        cardThemeButton(theme: Themes.Halloween, label: "Halloween", symbol: "theatermasks.fill")
    }
    
    var foodThemeButton: some View {
        cardThemeButton(theme: Themes.Food, label: "Food", symbol: "fork.knife")
    }
    
    var animalThemeButton: some View {
        cardThemeButton(theme: Themes.Animals, label: "Animals", symbol: "pawprint.fill")
    }
    
    
    func cardThemeButton(theme: Themes, label: String, symbol: String) -> some View {
        Button(action: {
            self.activeTheme = theme
            var emojisToUse: [String];
            switch(theme){
                case Themes.Halloween:
                    emojisToUse = halloweenEmojis
                case Themes.Food:
                    emojisToUse = foodEmojis
                case Themes.Animals:
                    emojisToUse = animalEmojis
            case Themes.None:
                    emojisToUse = []
            }
            let randomCount = Int.random(in: 2..<emojisToUse.count)
            emojisToUse = Array(emojisToUse[0..<randomCount])
            emojisToUse = emojisToUse + emojisToUse + emojisToUse
//            self.emojis = emojisToUse.shuffled()
            self.cardCount = emojisToUse.count
            }, label: {
                HStack {
                    Image(systemName: symbol).font(.largeTitle)
                    Text(label)
                }
            
        })
        .disabled(activeTheme == theme)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack (alignment: .center){
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group  {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
