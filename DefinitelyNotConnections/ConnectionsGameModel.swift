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
            Category(name: "Reasons Alex Loves Caro (Amongst Others)", boxTexts: ["Smart", "Thoughtful", "Funny", "Crazy"], colour: .yellow, id: 0),
            Category(name: "Caro's Titles", boxTexts: ["Stupido", "Queen Of Alex's Heart", "Ruler Of Alex's Life", "Duchess Dumpling"], colour: .green, id: 1),
            Category(name: "Things Alex Is", boxTexts: ["Smort", "Smudge", "Wrong", "Banana Boy"], colour: .blue, id: 2),
            Category(name: "Things That Live At The Top Of Caro's Brain", boxTexts: ["Banana", "Eggdoor", "Oops", "Bubbles"], colour: .purple, id: 3)
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
    
    func clickClueBox(clueBox: ClueBox) {
        if (self.gameState.areUnselectedClueBoxesClickable() || clueBox.isSelected) {
            clueBox.click()
        }
    }
    
    func isShuffleClickable() -> Bool {
        return self.gameState.isShuffleClickable()
    }
    
    func shuffleClueBoxes() {
        // Redundant because always true, but fits the pattern of others
        if isShuffleClickable() {
            self.gameState.shuffleClueBoxes()
        }
    }
    
    func isDeselectAllClickable() -> Bool {
        return self.gameState.isDeselectAllClickable()
    }
    
    func deselectAllClueBoxes() {
        if isDeselectAllClickable() {
            self.gameState.deselectAllClueBoxes()
        }
    }
    
    func isSubmitClickable() -> Bool {
        return self.gameState.isSubmitClickable()
    }
    
    func submitSelection() -> Bool {
        let selectedBoxIDs: [Int] = getSelectedClueBoxes().map({ $0.id })
        let alreadyGuessed: Bool = selectionAlreadyGuessed(selectedBoxIDs: selectedBoxIDs)
        var correct: Bool = true

        if alreadyGuessed {
            activatePopup(popupText: self.alreadyGuessedText)
        } else if isSubmitClickable() {
            let guess: Guess = computeGuess(selectedBoxIDs: selectedBoxIDs)
            self.gameState.addGuess(guess: guess)
            if let correctCategoryIndex = guess.correctCategoryID {
                self.gameState.completeCategory(category: self.categories[correctCategoryIndex])
                self.gameState.removeSelectedClueBoxes()
            } else {
                self.gameState.madeMistake()
                if guess.oneAway {
                    activatePopup(popupText: self.oneAwayText)
                }
                correct = false
            }
        }
        return correct
    }
    
    func selectionAlreadyGuessed(selectedBoxIDs: [Int]) -> Bool {
        var selectionAlreadyGuessed: Bool = false
        for guess in getGuesses() {
            if guess.clueBoxes.map({ $0.id }).sorted() == selectedBoxIDs.sorted() {
                selectionAlreadyGuessed = true
                break
            }
        }
        return selectionAlreadyGuessed
    }
    
    func computeGuess(selectedBoxIDs: [Int]) -> Guess {
        var correctCategoryIndex: Int? = nil
        var oneAway = false
        
        categoryLoop: for (categoryIndex, category) in self.categories.enumerated() {
            let numSameSelections: Int = checkNumSameSelections(selectedIDs: selectedBoxIDs, categoryIDs: category.clueBoxes.map({$0.id}))
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
        return Guess(clueBoxes: getSelectedClueBoxes(), correctCategoryID: correctCategoryIndex, oneAway: oneAway, id: self.gameState.getNumGuesses())
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
