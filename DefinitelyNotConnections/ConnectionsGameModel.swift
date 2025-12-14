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
    
    func startPlaying() {
        self.gameState.startPlaying()
    }
    
    func finishPlaying() {
        self.gameState.finishPlaying()
    }
    
    func admirePuzzle() {
        self.gameState.admirePuzzle()
    }
    
    func getCurrentGamePhase() -> GamePhase {
        self.gameState.getCurrentGamePhase()
    }

    func getGuesses() -> [Guess] {
        return self.gameState.getGuesses()
    }
    
    func setLastGuessShakesBoxes(shakesBoxes: Bool) {
        self.gameState.setLastGuessShakesBoxes(shakesBoxes: shakesBoxes)
    }
    
    func getLastGuessShakesBoxes() -> Bool {
        return self.gameState.getLastGuessShakesBoxes()
    }

    func getNumMistakesRemaining() -> Int {
        self.gameState.getNumMistakesRemaining()
    }
    
    func resetNumMistakesRemaining() {
        self.gameState.resetNumMistakesRemaining()
    }
    
    func getCompletedCategories() -> [Category] {
        return self.gameState.getCompletedCategories()
    }
    
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.gameState.getRemainingClueBoxes()
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.gameState.getSelectedClueBoxes()
    }
    
    func getNextGuessID() -> Int {
        return self.gameState.getNextGuessID()
    }
    
    func clickClueBox(clueBox: ClueBox) {
        if (self.gameState.areUnselectedClueBoxesClickable() || clueBox.isSelected) {
            clueBox.click()
        }
    }
    
    func shuffleClueBoxes() {
        self.gameState.shuffleClueBoxes()
    }
    
    func isDeselectAllClickable() -> Bool {
        return self.gameState.isDeselectAllClickable()
    }
    
    func deselectAllClueBoxes() {
        self.gameState.deselectAllClueBoxes()
    }
    
    func isSubmitClickable() -> Bool {
        return self.gameState.isSubmitClickable()
    }
    
    func submitSelection() {
        let selectedBoxes: [ClueBox] = getSelectedClueBoxes()
        let alreadyGuessed: Bool = selectionAlreadyGuessed(selectedBoxIDs: getClueBoxIDs(clueBoxes: selectedBoxes))
        var correct: Bool?

        if alreadyGuessed {
            activatePopup(popupText: self.alreadyGuessedText)
        } else {
            let guess: Guess = computeGuess(selectedBoxes: selectedBoxes, guessID: getNextGuessID())
            self.gameState.addGuess(guess: guess)
            if let correctCategoryIndex = guess.correctCategoryID {
                self.gameState.completeCategory(category: self.categories[correctCategoryIndex])
                self.gameState.removeSelectedClueBoxes()
                correct = true
            } else {
                self.gameState.madeMistake()
                if guess.oneAway {
                    activatePopup(popupText: self.oneAwayText)
                }
                correct = false
            }
        }

        if correct == nil || correct == true {
            setLastGuessShakesBoxes(shakesBoxes: false)
        } else {
            setLastGuessShakesBoxes(shakesBoxes: true)
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
        self.gameState.activateSelectedBoxesShake()
    }
    
    func deactivateSelectedBoxesShake() {
        self.gameState.deactivateSelectedBoxesShake()
    }
}
