//
//  Guess.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation


struct Guess: Identifiable {
    let clueBoxes: [ClueBox]
    let correctCategoryID: Int?
    let oneAway: Bool
    let id: Int
    
    func getGuessText() -> String {
        var guessText = "Guess \(self.id): \(concatBoxTexts(clueBoxes: self.clueBoxes))"
        if correctCategoryID != nil {
            guessText += " (Correct!)"
        } else if self.oneAway {
            guessText += " (One away!)"
        }
        return guessText
    }
}
