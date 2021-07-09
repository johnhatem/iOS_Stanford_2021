//
//  GameTheme.swift
//  homework2
//
//  Created by John Hatem on 04/07/2021.
//

import Foundation

let vehicleEmojis = ["🚂", "🚀", "✈️", "🚁", "🚗", "🚌", "🚜", "🛶", "🚔", "🚑", "🚚", "🚲", "🛺", "🚈", "🚢", "🚤", "⛵️", "🚒", "🏎", "🚟", "🛴", "🛩", "⛽️", "🚦"]
let birthdayEmojis = ["🍭","🍬", "🎃", "🎉", "🎂", "🍰", "🧁", "🍥", "🥮", "🎁", "🎊", "🥳"]
let animalEmojis = ["🐶", "🐭", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐴"]
let halloweenEmojis = ["💀", "👻", "🎃"]
let flagEmojis = ["🇧🇷", "🇦🇲", "🇺🇸", "🇫🇷", "🇬🇧", "🇦🇽", "🇩🇰", "🇳🇱"]
let toolEmojis = ["🔨", "🛠", "🔧", "🪛", "🪚", "🪓"]

struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairsOfCards: Int
    let themeColor: String
}
