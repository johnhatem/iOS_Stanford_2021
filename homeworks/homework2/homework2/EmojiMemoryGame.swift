//
//  EmojiMemoryGame.swift
//  homework2
//
//  Created by John Hatem on 04/07/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private var theme: Theme
    @Published private var model: MemoryGame<String>
    
    static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }
    
    
    init() {
        theme = GameThemes.getGameTheme()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var themeName: String {
        theme.name
    }
    
    var themeColor: [Color] {
        stringToColor(of: theme.color)
    }
    
    private func stringToColor(of colors: [String]) -> [Color]{
        var convertedColors: [Color] = []
        for color in colors {
            switch(color) {
            case "orange":
                convertedColors.append(Color.orange)
            case "red":
                convertedColors.append(Color.red)
            case "purple":
                convertedColors.append(Color.purple)
            case "blue":
                convertedColors.append(Color.blue)
            case "green":
                convertedColors.append(Color.green)
            case "yellow":
                convertedColors.append(Color.yellow)
            case "gray":
                convertedColors.append(Color.gray)
            default:
                convertedColors.append(Color.white)
            }
        }
        return convertedColors
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() { // Task 11
        theme = GameThemes.getGameTheme()
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
