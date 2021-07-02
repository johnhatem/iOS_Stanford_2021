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

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id:pairIndex*2))
            cards.append(Card(content: content, id:pairIndex*2 + 1))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), // where: { aCardInTheCardsArray in aCardInTheCardsArray.id == card.id }
           !cards[chosenIndex].isFaceUp, // Face up cards are not clickable //the comma works as an "&&" operator
           !cards[chosenIndex].isMatched // matched cards are not clickable
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices { // for index in 0..<cards.count
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
        
    
    /*:
     - Note:
     We put the struct 'Card' inside MemoryGame cause mostly this is a naming thing.
     This 'Card' is now called MemoryGame.Card. so outside of the MemoryGame struct, we need to use MemoryGame.Card to use this 'Card' struct.
     We do this, because by NESTING Card in MemoryGame, we will know that the card we use is a memory game card and not poker cards for example.
     */
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // We can use String as the content type since we will use emojis. But we want the MemoryGame to be UI independent so we use a don't-care type.
        var id: Int //This var is required to conform to Identifiable protocol
    }
}
