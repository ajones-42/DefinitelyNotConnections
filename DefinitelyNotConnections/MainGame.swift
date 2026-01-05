//
//  Game.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import Foundation

@Observable
class MainGame {
    let allCategories: [Category]
    var gameGrid: GameGrid
    var guesses: [Guess]
    var numMistakesRemaining: Int
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.guesses = []
        self.numMistakesRemaining = 4
    }
    
    func resetGame() {
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.guesses = []
        self.numMistakesRemaining = 4
    }
    
    func getNumMistakesRemaining() -> Int {
        return self.numMistakesRemaining
    }
    
    func madeMistake() {
        self.numMistakesRemaining -= 1
    }
    
    func resetNumMistakesRemaining() {
        self.numMistakesRemaining = 4
    }
    
    func computeGuess(selectedBoxes: [ClueBox], guessID: Int) -> Guess {
        var correctCategoryIndex: Int? = nil
        var oneAway = false
        
        categoryLoop: for (categoryIndex, category) in self.allCategories.enumerated() {
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
        return Guess(clueBoxes: selectedBoxes, correctCategoryID: correctCategoryIndex, oneAway: oneAway, id: guessID)
    }
    
    func addGuess(guess: Guess) {
        self.guesses.append(guess)
    }
    
    func getGuesses() -> [Guess] {
        return self.guesses
    }
    
    func getNextGuessID() -> Int {
        return self.guesses.count
    }
    
    func selectionAlreadyGuessed(selectedBoxIDs: [Int]) -> Bool {
        var selectionAlreadyGuessed: Bool = false
        for guess in self.getGuesses() {
            if getClueBoxIDs(clueBoxes: guess.clueBoxes).sorted() == selectedBoxIDs.sorted() {
                selectionAlreadyGuessed = true
                break
            }
        }
        return selectionAlreadyGuessed
    }
}
