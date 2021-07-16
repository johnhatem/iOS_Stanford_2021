//
//  Memorize_lec_2_0App.swift
//  Memorize_lec_2.0
//
//  Created by John Hatem on 24/05/2021.
//

import SwiftUI

@main
struct Memorize_lec_2_0App: App {
    // using 'let' here does not mean that the game will not change. EmojiMemoryGame is a class, with let the reference (or pointer) to the game will not change but the game itself can and will change.
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
