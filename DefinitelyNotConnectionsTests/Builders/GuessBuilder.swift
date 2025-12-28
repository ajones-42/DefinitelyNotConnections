//
//  GuessBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

struct GuessBuilder {
    var clueBoxes: [ClueBox] = []
    var correctCategoryID: Int? = nil
    var oneAway: Bool = false
    var id: Int = 0
    
    mutating func withClueBoxes(clueBoxes: [ClueBox]) -> GuessBuilder {
        self.clueBoxes = clueBoxes
        return self
    }
    
    mutating func withCorrectCategoryID(correctCategoryID: Int?) -> GuessBuilder {
        self.correctCategoryID = correctCategoryID
        return self
    }
    
    mutating func withOneAway(oneAway: Bool) -> GuessBuilder {
        self.oneAway = oneAway
        return self
    }
    
    mutating func withID(id: Int) -> GuessBuilder {
        self.id = id
        return self
    }
    
    func build() -> Guess {
        return Guess(clueBoxes: self.clueBoxes, correctCategoryID: self.correctCategoryID, oneAway: self.oneAway, id: self.id)
    }
}
