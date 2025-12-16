//
//  ConnectionsGameModel.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import Foundation
import SwiftUI

@Observable
class ConnectionsGameModel {
    private(set) var gameState: GameState
    let categories: [Category]
    let allClueBoxes: [ClueBox]
    
    var popupTrigger: Bool = false // Actual value doesn't matter, but must change to trigger OneAway/AlreadyGuessed.
    var popupText: String = ""
    let oneAwayText: String = "One away!"
    let alreadyGuessedText: String = "Already guessed!"
    
    init() {
        self.categories = ConnectionsGameModel.getCategories()
        self.allClueBoxes = Array(self.categories.map({ $0.clueBoxes }).joined())
        self.gameState = GameState(clueBoxes: self.allClueBoxes)
        shuffleClueBoxes()
    }
    
    func resetGame() {
        self.gameState = GameState(clueBoxes: self.allClueBoxes)
        deselectAllClueBoxes()
        shuffleClueBoxes()
    }
    
    static func getCategories() -> [Category] {
        return [
            Category(name: "Category 0", boxTexts: ["Clue0", "Clue1", "Clue2", "Clue3"], colour: .yellow, id: 0),
            Category(name: "Category 1", boxTexts: ["Clue4", "Clue5", "Clue6", "Clue7"], colour: .green, id: 1),
            Category(name: "Category 2", boxTexts: ["Clue8", "Clue9", "Clue10", "Clue11"], colour: .blue, id: 2),
            Category(name: "Category 3", boxTexts: ["Clue12", "Clue13", "Clue14", "Clue15"], colour: .purple, id: 3)
        ]
    }
    
    // GamePhase
    
    func startPlaying() {
        self.gameState.gamePhase = .playing
    }
    
    func finishPlaying() {
        self.gameState.gamePhase = .finished
    }
    
    func admirePuzzle() {
        self.gameState.gamePhase = .admiring
    }
    
    func getCurrentGamePhase() -> GamePhase {
        return self.gameState.gamePhase
    }
    
    // ClueBoxes
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.gameState.remainingClueBoxes.filter { $0.isSelected }
    }
    
    func getNumSelectedClueBoxes() -> Int {
        return getSelectedClueBoxes().count
    }
    
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.gameState.remainingClueBoxes
    }
    
    func clickClueBox(clueBox: ClueBox) {
        if (getNumSelectedClueBoxes() < 4 || clueBox.isSelected) {
            clueBox.click()
        }
    }
    
    func shuffleClueBoxes() {
        self.gameState.remainingClueBoxes.shuffle()
    }
    
    func removeSelectedClueBoxes() {
        self.gameState.remainingClueBoxes.removeAll(where: { $0.isSelected })
    }
    
    func isDeselectAllClickable() -> Bool {
        return getNumSelectedClueBoxes() > 0
    }
    
    func deselectAllClueBoxes() {
        for clueBox in self.gameState.remainingClueBoxes {
            clueBox.deselect()
        }
    }
    
    func isSubmitClickable() -> Bool {
        return getNumSelectedClueBoxes() == 4
    }
    
    // Guesses
    
    func addGuess(guess: Guess) {
        self.gameState.guesses.append(guess)
    }

    func getGuesses() -> [Guess] {
        return self.gameState.guesses
    }
    
    func getNextGuessID() -> Int {
        return self.gameState.guesses.count
    }
    
    func getLastGuessShakesBoxes() -> Bool {
        return self.gameState.lastGuessShakesBoxes
    }
    
    func guessIsCorrect(guess: Guess) -> Bool {
        return guess.correctCategoryID != nil
    }
    
    // Mistakes

    func getNumMistakesRemaining() -> Int {
        return self.gameState.numMistakesRemaining
    }
    
    func madeMistake() {
        self.gameState.numMistakesRemaining -= 1
    }
    
    func resetNumMistakesRemaining() {
        self.gameState.numMistakesRemaining = 4
    }
    
    // Categories
    
    func completeCategory(correctCategoryIndex: Int) {
        self.gameState.completedCategories.append(self.categories[correctCategoryIndex])
    }
    
    func getCompletedCategories() -> [Category] {
        return self.gameState.completedCategories
    }
    
    
    func correctGuess(guess: Guess) {
        self.gameState.lastGuessShakesBoxes = false
        completeCategory(correctCategoryIndex: guess.correctCategoryID!)
        removeSelectedClueBoxes()
        if self.gameState.completedCategories.count == 4 {
            admirePuzzle()
        }
    }
    
    func incorrectGuess(guess: Guess) {
        self.gameState.lastGuessShakesBoxes = true
        madeMistake()
        if guess.oneAway {
            activatePopup(popupText: self.oneAwayText)
        }
    }
    
    func alreadyGuessed() {
        self.gameState.lastGuessShakesBoxes = true
        activatePopup(popupText: self.alreadyGuessedText)
    }


    
    func submitSelection() {
        let selectedBoxes: [ClueBox] = getSelectedClueBoxes()

        if selectionAlreadyGuessed(selectedBoxIDs: getClueBoxIDs(clueBoxes: selectedBoxes)) {
            alreadyGuessed()
        } else {
            let guess: Guess = computeGuess(selectedBoxes: selectedBoxes, guessID: getNextGuessID())
            addGuess(guess: guess)
            
            if guessIsCorrect(guess: guess) {
                correctGuess(guess: guess)
            } else {
                incorrectGuess(guess: guess)
            }
        }
    }
    
    func selectionAlreadyGuessed(selectedBoxIDs: [Int]) -> Bool {
        var selectionAlreadyGuessed: Bool = false
        for guess in getGuesses() {
            if getClueBoxIDs(clueBoxes: guess.clueBoxes).sorted() == selectedBoxIDs.sorted() {
                selectionAlreadyGuessed = true
                break
            }
        }
        return selectionAlreadyGuessed
    }
    
    func computeGuess(selectedBoxes: [ClueBox], guessID: Int) -> Guess {
        var correctCategoryIndex: Int? = nil
        var oneAway = false
        
        categoryLoop: for (categoryIndex, category) in self.categories.enumerated() {
            let numSameSelections: Int = checkNumSameSelections(selectedIDs: getClueBoxIDs(clueBoxes: selectedBoxes), categoryIDs: getClueBoxIDs(clueBoxes: category.clueBoxes))
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
    
    func checkNumSameSelections(selectedIDs: [Int], categoryIDs: [Int]) -> Int {
        var numSameSelections: Int = 0
        for selectedID in selectedIDs {
            numSameSelections += (categoryIDs.contains(selectedID)) ? 1 : 0
        }
        return numSameSelections
    }
    
    func activatePopup(popupText: String) {
        self.popupText = popupText
        self.popupTrigger.toggle()
    }
    
    func activateSelectedBoxesShake() {
        getSelectedClueBoxes().forEach { box in
            box.activateShake()
        }
    }
    
    func deactivateSelectedBoxesShake() {
        getSelectedClueBoxes().forEach { box in
            box.deactivateShake()
        }
    }
}
