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
    private(set) var state: GameState
    private(set) var categories: [Category]
    // Can't compute self.categories since the order completed categories are shown in will change
    private(set) var completedCategories: [Category] {
        didSet {
            if completedCategories.count == 4 {
                self.state = .finished
            }
        }
    }
    
    private(set) var remainingClueBoxes: [ClueBox]
    var selectedBoxes: [ClueBox] {
        self.remainingClueBoxes.filter { $0.isSelected == true }
    }
    var numSelectedBoxes: Int {
        self.selectedBoxes.count
    }
    private(set) var numMistakesRemaining: Int
    
    private(set) var guesses: [Guess]
    
    var popupTrigger: Bool = false // Actual value doesn't matter, but must change to trigger OneAway/AlreadyGuessed.
    var popupText: String = ""
    let oneAwayText: String = "One away!"
    let alreadyGuessedText: String = "Already guessed!"
    
    let shuffleIsClickable: Bool = true // Always clickable
    var deselectAllIsClickable: Bool {
        return self.numSelectedBoxes > 0
    }
    var submitIsClickable: Bool {
        return self.numSelectedBoxes == 4
    }
    
    init() {
        self.state = .setup
        self.categories = ConnectionsGameModel.getCategories()
        self.completedCategories = []
        self.guesses = []
        self.numMistakesRemaining = 4
        self.remainingClueBoxes = []
        self.remainingClueBoxes.append(contentsOf: Array(self.categories.map({ $0.clueBoxes }).joined()))
        shuffleClueBoxes()
    }
    
    func resetGame() {
        self.state = .setup
        self.categories = ConnectionsGameModel.getCategories()
        self.completedCategories = []
        self.guesses = []
        self.numMistakesRemaining = 4
        self.remainingClueBoxes = Array(self.categories.map({ $0.clueBoxes }).joined())
        shuffleClueBoxes()
    }
    
    func startPlaying() {
        self.state = .playing
    }
    
    func finishedPlaying() {
        self.state = .finished
    }
    
    func admirePuzzle() {
        self.state = .admiring
    }

    static func getCategories() -> [Category] {
        return [
            Category(name: "Reasons Alex Loves Caro (Amongst Others)", boxTexts: ["Smart", "Thoughtful", "Funny", "Crazy"], colour: .yellow, id: 0),
            Category(name: "Things Caro Is", boxTexts: ["Stupido", "Queen Of Alex's Heart", "Ruler Of Alex's Life", "Duchess Dumpling"], colour: .green, id: 1),
            Category(name: "Things Alex Is", boxTexts: ["Smort", "Smudge", "Wrong", "Banana Boy"], colour: .blue, id: 2),
            Category(name: "Things That Live At The Top Of Caro's Brain", boxTexts: ["Banana", "Eggdoor", "Oops", "Bubbles"], colour: .purple, id: 3)
        ]
    }
    
    func clickClueBox(clueBox: ClueBox) {
        if self.numSelectedBoxes < 4 || clueBox.isSelected {
            if let boxIndex = getClueBoxIndex(id: clueBox.id) {
                self.remainingClueBoxes[boxIndex].click()
            }
        }
    }
    
    func getClueBoxIndex(id: Int) -> Int? {
        return self.remainingClueBoxes.firstIndex(where: { $0.id == id })
    }
    
    func submitSelection() {
        let selectedBoxIDs: [Int] = self.selectedBoxes.map({ $0.id })
        let alreadyGuessed: Bool = selectionAlreadyGuessed(selectedBoxIDs: selectedBoxIDs)

        if alreadyGuessed {
            activatePopup(popupText: self.alreadyGuessedText)
        } else if self.submitIsClickable {
            let guess: Guess = computeGuess(selectedBoxIDs: selectedBoxIDs)
            guesses.append(guess)
            if let correctCategoryIndex = guess.correctCategoryID {
                self.completedCategories.append(self.categories[correctCategoryIndex])
                removeSelectedBoxes(selectedBoxIDs: selectedBoxIDs)
            } else {
                self.numMistakesRemaining -= 1
                if guess.oneAway {
                    activatePopup(popupText: self.oneAwayText)
                }
            }
        }
    }
    
    func selectionAlreadyGuessed(selectedBoxIDs: [Int]) -> Bool {
        var selectionAlreadyGuessed: Bool = false
        for guess in guesses {
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
        return Guess(clueBoxes: self.selectedBoxes, correctCategoryID: correctCategoryIndex, oneAway: oneAway, id: self.guesses.count)
    }
    
    func checkNumSameSelections(selectedIDs: [Int], categoryIDs: [Int]) -> Int {
        var numSameSelections: Int = 0
        for selectedID in selectedIDs {
            numSameSelections += (categoryIDs.contains(selectedID)) ? 1 : 0
        }
        return numSameSelections
    }
    
    func removeSelectedBoxes(selectedBoxIDs: [Int]) {
        for selectedBoxId in selectedBoxIDs {
            if let boxIndex = getClueBoxIndex(id: selectedBoxId) {
                self.remainingClueBoxes.remove(at: boxIndex)
            }
        }
    }
    
    func activatePopup(popupText: String) {
        self.popupText = popupText
        self.popupTrigger.toggle()
    }

    func deselectAll() {
        if self.deselectAllIsClickable {
            for index in remainingClueBoxes.indices {
                self.remainingClueBoxes[index].isSelected = false
            }
        }
    }
    
    func shuffleClueBoxes() {
        self.remainingClueBoxes.shuffle()
    }
    
    func resetNumMistakesRemaining() {
        self.numMistakesRemaining = 4
    }
}
