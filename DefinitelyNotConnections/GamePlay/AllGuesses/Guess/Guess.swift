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
    
    init(allCategories: [Category], selectedBoxes: [ClueBox], id: Int) {
        self.clueBoxes = selectedBoxes
        self.id = id

        var correctCategoryIndex: Int? = nil
        var oneAway = false
        
        categoryLoop: for (categoryIndex, category) in allCategories.enumerated() {
            let numSameSelections: Int = getNumSameElementsInArrays(lhs: getClueBoxIDs(clueBoxes: selectedBoxes), rhs: getClueBoxIDs(clueBoxes: category.clueBoxes))
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
    
    init(clueBoxes: [ClueBox], correctCategoryID: Int?, oneAway: Bool, id: Int) {
        self.clueBoxes = clueBoxes
        self.correctCategoryID = correctCategoryID
        self.oneAway = oneAway
        self.id = id
    }
    
    func getGuessText() -> String {
        var guessText = "Guess \(self.id + 1): \(concatBoxTexts(clueBoxes: self.clueBoxes))"
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
