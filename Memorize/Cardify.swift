//
//  Cardify.swift
//  Memorize
//
//  Created by Alan Romano on 8/16/24.
//

import Foundation
import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
            
    var animatableData: Double {
        get {return rotation}
        set {rotation = newValue}
    }
    
    
    func body(content: Content) -> some View {
        ZStack (alignment: .center){
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
            
        }
        
        .rotation3DEffect(
            .degrees(rotation),
                  axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
        )
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
