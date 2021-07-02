//
//  MemoryGame.swift
//  Memorize_lec_2.0
//
//  Created by John Hatem on 24/06/2021.
//

/*
    This is the MODEL of MVVM
 */

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    /*:
     - Note:
     We put the struct 'Card' inside MemoryGame cause mostly this is a naming thing.
     This 'Card' is now called MemoryGame.Card. so outside of the MemoryGame struct, we need to use MemoryGame.Card to use this 'Card' struct.
     We do this, because by NESTING Card in MemoryGame, we will know that the card we use is a memory game card and not poker cards for example.
     */
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // We can use String as the content type since we will use emojis. But we want the MemoryGame to be UI independent so we use a don't-care type.
    }
}
