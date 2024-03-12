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

let halloweenEmojis = ["👻", "🎃", "😈", "🕷️", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭" ]
let foodEmojis = ["🍎", "🍒", "🍋", "🫒", "🍕", "🍟", "🥞", "🥐", "🫔", "🌮", "🍰", "🍙" ]
let animalEmojis = ["🐥", "🐴", "🐝", "🕷️", "🐟", "🦑", "🐱", "🐶", "🐻‍❄️", "🦆", "🦊", "🐓" ]

struct EmojiMemoryGameView: View {
    
    var viewModel: EmojiMemoryGame
    
    @State var emojis: [String] = []
    @State var activeTheme: Themes = Themes.None
    
    @State var cardCount = 0
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
//            cardCountAdjusters
            themeChoosers
        }
       .padding()

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode:.fit)
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
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//                cardCount += offset
//            }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > (emojis.count - 1))
//    }
//    
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
//    }
//    
//    var cardAdder: some View {
//        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
//    }
    
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
            self.emojis = emojisToUse.shuffled()
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
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack (alignment: .center){
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group  {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    EmojiMemoryGameView()
}
