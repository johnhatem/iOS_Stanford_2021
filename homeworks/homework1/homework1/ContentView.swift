//
//  ContentView.swift
//  homework1
//
//  Created by John Hatem on 04/06/2021.
//

import SwiftUI
var vehicles: [String] = ["🚂", "🚀", "✈️", "🚁", "🚗", "🚌", "🚜", "🛶", "🚔", "🚑", "🚚", "🚲", "🛺", "🚈", "🚢", "🚤", "⛵️", "🚒", "🏎", "🚟", "🛴", "🛩", "⛽️", "🚦"]
var birthday: [String] = ["🍭","🍬", "🎃", "🎉", "🎂", "🍰", "🧁", "🍥", "🥮", "🎁", "🎊", "🥳"]
var animals: [String] = ["🐶", "🐭", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐴"]

struct ContentView: View {
    @State var emojis = vehicles.shuffled()
    @State var emojiCount: Int = 17
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojiCount)))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                Spacer()
                vehiclesThemeButton
                Spacer()
                birthdayThemeButton
                Spacer()
                animalsThemeButton
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    var vehiclesThemeButton: some View {
        Button {
            emojis = vehicles.shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "car").font(.largeTitle)
                Text("Vehicles").font(.body)
            }
        }
    }
    
    var birthdayThemeButton: some View {
        Button {
            emojis = birthday.shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "gift").font(.largeTitle)
                Text("Birthday").font(.body)
            }
        }
    }
    
    var animalsThemeButton: some View {
        Button {
            emojis = animals.shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "hare").font(.largeTitle)
                Text("Animals").font(.body)
            }
        }
    }
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        if cardCount <= 4 {
            return 130
        } else if cardCount <= 9 {
            return 90
        } else if cardCount <= 20 {
            return 80
        }
        return 70
    }
}


struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
