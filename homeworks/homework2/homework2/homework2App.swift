//
//  homework2App.swift
//  homework2
//
//  Created by John Hatem on 03/07/2021.
//

import SwiftUI

@main
struct homework2App: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
