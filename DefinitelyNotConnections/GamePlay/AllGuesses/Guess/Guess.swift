//
//  Guess.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation


struct Guess: Identifiable {
    let clueBoxIDs: [UUID]
    let clues: [String]
    let isCorrect: Bool
    let oneAway: Bool
    let id: Int
    
    init(clues: [String], clueBoxIDs: [UUID], isCorrect: Bool, oneAway: Bool, id: Int) {
        self.clues = clues
        self.clueBoxIDs = clueBoxIDs
        self.isCorrect = isCorrect
        self.oneAway = oneAway
        self.id = id
    }
    
    func getGuessText() -> String {
        var guessText = "Guess \(self.id + 1): \(concatClues(clues: self.clues))"
        if self.isCorrect {
            guessText += " (Correct!)"
        } else if self.oneAway {
            guessText += " (One away!)"
        }
        return guessText
    }
}
