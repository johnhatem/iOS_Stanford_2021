//
//  ContentView.swift
//  homework2
//
//  Created by John Hatem on 03/07/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            
            HStack {
                Text("Score: \(viewModel.score)") // Task 15 , 16
                    .gradientForeground(colors: viewModel.themeColor)
                    .font(.title2)
                    .padding()
                Spacer()
                Button("New Game") { // Task 10, 11
                    viewModel.newGame()
                }
            }
            .padding(.horizontal)
            
            Text("\(viewModel.themeName)") // Task 14
                .font(.largeTitle)
                .gradientForeground(colors: viewModel.themeColor) // Task 15, 16
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.themeColor)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                                
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: [Color]
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(LinearGradient(gradient: Gradient(colors: color), startPoint: .leading, endPoint: .bottom), lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill(LinearGradient(gradient: Gradient(colors: color), startPoint: .leading, endPoint: .bottom))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        Group {
            ContentView(viewModel: game)
                .preferredColorScheme(.light)
            ContentView(viewModel: game)
                .preferredColorScheme(.dark)
        }
    }
}


// Task 15, 16
extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}
