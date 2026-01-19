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
    let isOneAway: Bool
    let id: UUID
    
    init(clues: [String], clueBoxIDs: [UUID], isCorrect: Bool, isOneAway: Bool) {
        self.clues = clues
        self.clueBoxIDs = clueBoxIDs
        self.isCorrect = isCorrect
        self.isOneAway = isOneAway
        self.id = UUID()
    }
    
    func getGuessText() -> String {
        var guessText = "\(concatClues(clues: self.clues))"
        if self.isCorrect {
            guessText += " (Correct!)"
        } else if self.isOneAway {
            guessText += " (One away!)"
        }
        return guessText
    }
}
