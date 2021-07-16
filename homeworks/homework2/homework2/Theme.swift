//
//  GameTheme.swift
//  homework2
//
//  Created by John Hatem on 04/07/2021.
//

import Foundation

// MARK: - task 3
struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairsOfCards: Int
    let color: [String] // Extra Credit Task 3
    
    init(name: String, emojis: [String], numberOfPairsOfCards: Int, themeColor: [String]) {
        self.name = name
        self.emojis = emojis.removingDuplicates().shuffled()  // task 5, 6
        if numberOfPairsOfCards > emojis.count { // task 7
            self.numberOfPairsOfCards = emojis.count
        } else {
            self.numberOfPairsOfCards = numberOfPairsOfCards
        }
        self.color = themeColor
    }
    
    
    // Extra Credit Task 1
    ///default to use all the emoji available in the theme if the code that creates the Theme doesn’t want to explicitly specify how many pairs to use.
    init(name: String, emojis: [String], themeColor: [String]) {
        self.name = name
        self.emojis = emojis.removingDuplicates().shuffled()  // task 5, 6
        self.color = themeColor
        self.numberOfPairsOfCards = emojis.count
    }
    
    // Extra Credit Task 2
    init(name: String, emojis: [String], rangeOfPairsOfCards: Range<Int>, themeColor: [String]) {
        self.name = name
        self.emojis = emojis.removingDuplicates().shuffled()  // task 5, 6
        self.color = themeColor
        
        let randomNumberOfPairsOfCards = Int.random(in: rangeOfPairsOfCards)
        if randomNumberOfPairsOfCards > emojis.count { // task 7
            self.numberOfPairsOfCards = emojis.count
        } else {
            self.numberOfPairsOfCards = randomNumberOfPairsOfCards
        }
    }
}

// Task 6
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter { element in
            addedDict.updateValue(true, forKey: element) == nil //adding new (key, value) returns nil
        }
    }
}

struct GameThemes {
    
    private static let gameThemes: [Theme] = getGameThemes()
    
    public static func getGameTheme() -> Theme {
        if let gameTheme = gameThemes.randomElement() {
            return gameTheme
        } else {
            return Theme(name: "No Games Available", emojis: [""], numberOfPairsOfCards: 0, themeColor: [""])
        }
    }
    
    private static func getGameThemes() -> [Theme] {
        return [vehiclesTheme(), birthdayTheme(), toolsTheme(), halloweenTheme(), zooTheme(), flagsTheme()]
    }
        
    private static func vehiclesTheme() -> Theme {
        let vehicleEmojis = ["🚂", "🚀", "✈️", "🚁", "🚗", "🚌", "🚜", "🛶", "🚔", "🚑", "🚚", "🚲", "🛺", "🚈", "🚢", "🚤", "⛵️", "🚒", "🏎", "🚟", "🛴", "🛩", "⛽️", "🚦"]
        // Task 4: At least one Theme in your game should show fewer pairs of cards than the number of emoji available in that theme.
        return Theme(name: "Vehicles", emojis: vehicleEmojis, numberOfPairsOfCards: 8, themeColor: ["orange", "red", "green"])
    }
    
    private static func birthdayTheme() -> Theme {
        let birthdayEmojis = ["🍭","🍬", "🎃", "🎉", "🎂", "🍰", "🧁", "🍥", "🥮", "🎁", "🎊", "🥳"]
        // Extra credit task 2
        return Theme(name: "Birtday", emojis: birthdayEmojis, rangeOfPairsOfCards: 5..<15, themeColor: ["red"])
    }
    
    private static func toolsTheme() -> Theme {
        let toolEmojis = ["🔨", "🛠", "🔧", "🪛", "🪚", "🪓"]
        // Extra credit task 1
        return Theme(name: "Tools", emojis: toolEmojis, themeColor: ["yellow", "green"])
    }
    
    private static func halloweenTheme() -> Theme {
        let halloweenEmojis = ["💀", "👻", "🎃"]
        return Theme(name: "Halloween", emojis: halloweenEmojis, themeColor: ["yellow", "red", "purple"])
    }
    
    private static func zooTheme() -> Theme {
        let animalEmojis = ["🐶", "🐭", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐴"]
        return Theme(name: "Zoo", emojis: animalEmojis, numberOfPairsOfCards: 10, themeColor: ["yellow"])
    }
    
    private static func flagsTheme() -> Theme {
        let flagEmojis = ["🇧🇷", "🇦🇲", "🇺🇸", "🇫🇷", "🇬🇧", "🇦🇽", "🇩🇰", "🇳🇱"]
        return Theme(name: "Flags", emojis: flagEmojis, themeColor: ["red", "blue", "orange"])
    }
}

