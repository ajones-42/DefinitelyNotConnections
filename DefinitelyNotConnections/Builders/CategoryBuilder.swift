//
//  CategoryBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation
import SwiftUI

struct CategoryBuilder {
    var name: String = "A Category"
    var boxTexts: [String] = ["A clue!", "Another clue!", "Yet another clue!", "Guess what, a clue!"]
    var clueBoxes: [ClueBox] = []
    var colour: Color = .red
    var id: Int = 0

    mutating func withName(name: String) -> CategoryBuilder {
        self.name = name
        return self
    }
    
    mutating func withBoxTexts(boxTexts: [String]) -> CategoryBuilder {
        self.boxTexts = boxTexts
        return self
    }
    
    mutating func withClueBoxes(clueBoxes: [ClueBox]) -> CategoryBuilder {
        self.clueBoxes = clueBoxes
        return self
    }
    
    mutating func withColour(colour: Color) -> CategoryBuilder {
        self.colour = colour
        return self
    }
    
    mutating func withID(id: Int) -> CategoryBuilder {
        self.id = id
        return self
    }
    
    func build() -> Category {
        if self.clueBoxes.isEmpty {
            return Category(name: self.name, boxTexts: self.boxTexts, colour: self.colour, id: self.id)
        } else {
            return Category(name: self.name, clueBoxes: self.clueBoxes, colour: self.colour, id: self.id)
        }
    }
}
