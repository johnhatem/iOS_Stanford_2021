//
//  EmojiMemoryGameView.swift
//  Memorize_lec_2.0
//
//  Created by John Hatem on 24/05/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // @ObservedObject: means that every time the viewModel changes (which is the ObservableObject), redraw the View.
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            if card.isMatched && !card.isFaceUp {
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                .padding(4)
                .onTapGesture { //express user intent to choose a card
                    game.choose(card)
                }
            }
        })

        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
}




struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()  
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        Group {
            EmojiMemoryGameView(game: game)
                .preferredColorScheme(.light)
        }
    }
}
