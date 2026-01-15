//
//  Guess.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation


struct Guess: Identifiable {
    let clueIDs: [UUID]
    let clues: [String]
    let correctCategoryID: Int?
    let oneAway: Bool
    let id: Int
    
    init(allCategories: [Category], selectedClueIDs: [UUID], selectedClues: [String], id: Int) {
        self.clueIDs = selectedClueIDs
        self.clues = selectedClues
        self.id = id

        var correctCategoryIndex: Int? = nil
        var oneAway = false
        
        categoryLoop: for (categoryIndex, category) in allCategories.enumerated() {
            let numSameSelections: Int = getNumSameElementsInArrays(lhs: self.clueIDs, rhs: category.clueIDs)
            switch numSameSelections {
            case 4:
                correctCategoryIndex = categoryIndex
                break categoryLoop
            case 3:
                oneAway = true
                break categoryLoop
            case 2:
                // No need to check further if 2 are correct
                break categoryLoop
            default:
                // Keep checking for 0 or 1 correct
                continue categoryLoop
            }
        }
        self.correctCategoryID = correctCategoryIndex
        self.oneAway = oneAway
    }
    
    init(clues: [String], clueIDs: [UUID], correctCategoryID: Int?, oneAway: Bool, id: Int) {
        self.clues = clues
        self.clueIDs = clueIDs
        self.correctCategoryID = correctCategoryID
        self.oneAway = oneAway
        self.id = id
    }
    
    func getGuessText() -> String {
        var guessText = "Guess \(self.id + 1): \(concatClues(clues: self.clues))"
        if correctCategoryID != nil {
            guessText += " (Correct!)"
        } else if self.oneAway {
            guessText += " (One away!)"
        }
        return guessText
    }
    
    func isCorrect() -> Bool {
        return self.correctCategoryID != nil
    }
}
