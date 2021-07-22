//
//  EmojiMemoryGame.swift
//  Memorize_lec_2.0
//
//  Created by John Hatem on 24/06/2021.
//

// This is the ViewModel in MVVM. It is not the View, BUT it is part of the UI (which is why it can and needs to import SwiftUI
// The ViewModel plays the role of the Gate Keeper.
// ObservableObject: the ObservableObject publishes to the world that something has changed. Classes that conform to this will get a default var called objectWillChange

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    // This static constant is also called type variable or type constant
    private static let emojis: [String] = ["🚂", "🚀", "✈️", "🚁", "🚗", "🚌", "🚜", "🛶", "🚔", "🚑",
                            "🚚", "🚲", "🛺", "🚈", "🚢", "🚤", "⛵️", "🚒", "🏎", "🚟"]
    
    // This is also called type function (It's a function on the type and not on instances of this type)
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 1) { pairIndex in
            emojis[pairIndex] // The full name is EmojiMemoryGame.emojis (you can use the shorthand name inside another static func (type function) but you need to write the whole name inside an instance func (see example below)
        }
    }
    
    // static members cannot be used on an instance of this class, so you need to specify the whole name
//    func foo() {
//        let x = emojis // will give an error
//        let x = EmojiMemoryGame.emojis
//    }
    

    // connection to the MODEL
    // @Published: Every time the model is changed, it will call 'objectWillChange.send()' to notify the View that a redraw is required
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
}
