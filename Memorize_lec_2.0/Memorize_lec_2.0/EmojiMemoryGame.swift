//
//  EmojiMemoryGame.swift
//  Memorize_lec_2.0
//
//  Created by John Hatem on 24/06/2021.
//

/*
    This is the ViewModel in MVVM. It is not the View, BUT it is part of the UI (which is why it can and needs to import SwiftUI
 
    The ViewModel plays the role of the Gate Keeper.
 */

import SwiftUI

class EmojiMemoryGame {
    // This static constant is also called type variable or type constant
    static let emojis: [String] = ["🚂", "🚀", "✈️", "🚁", "🚗", "🚌", "🚜", "🛶", "🚔", "🚑",
                            "🚚", "🚲", "🛺", "🚈", "🚢", "🚤", "⛵️", "🚒", "🏎", "🚟"]
    
    // This is also called type function (It's a function on the type and not on instances of this type)
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis[pairIndex] // The full name is EmojiMemoryGame.emojis (you can use the shorthand name inside another static func (type function) but you need to write the whole name inside an instance func (see example below)
        }
    }
    
    // static members cannot be used on an instance of this class, so you need to specify the whole name
//    func foo() {
//        let x = emojis // will give an error
//        let x = EmojiMemoryGame.emojis
//    }
    

    // connection to the MODEL
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
