//
//  MemoryGame.swift
//  homework2
//
//  Created by John Hatem on 03/07/2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0 // Task 15
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private var timestampOfLastChosenCard: Date?  // Extra Credit Task 4
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
        cards.shuffle() // Task 13
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                let timeDifferenceInSeconds = Int(timestampOfLastChosenCard!.distance(to: Date())) // Extra Credit Task 4
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += max(10 - timeDifferenceInSeconds, 1) * 2 // Extra Credit Task 4
                } else {
                    if cards[chosenIndex].isSeen { score -= max(10 - timeDifferenceInSeconds, 1) * 1} // Extra Credit Task 4
                    if cards[potentialMatchIndex].isSeen { score -= max(10 - timeDifferenceInSeconds, 1) * 1} // Extra Credit Task 4
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    if cards[index].isFaceUp {  // Task 15
                        cards[index].isSeen = true
                        cards[index].isFaceUp = false
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
            timestampOfLastChosenCard = Date()  // Extra Credit Task 4
        }
    }
    
    
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false // Task 15
        var content: CardContent
        var id: Int
    }
}

