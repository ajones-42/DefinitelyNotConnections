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
    private(set) var state: GameState = GameState.setup
    private(set) var remainingCategories: [Category]
    private(set) var completedCategories: [Category] = []
    
    private(set) var clueBoxes: [Category.ClueBox] = []
    var selectedBoxes: [Category.ClueBox] {
        self.clueBoxes.filter { $0.isSelected == true }
    }
    var numSelectedBoxes: Int {
        self.selectedBoxes.count
    }
    var numMistakesRemaining: Int = 4

    private(set) var guesses: [Guess] = []

    var popupTrigger: Bool = false // Actual value doesn't matter, but must change to trigger OneAway.
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
        self.remainingCategories = ConnectionsGameModel.getCategories()
        for category in remainingCategories {
            self.clueBoxes.append(contentsOf: category.clueBoxes)
        }
        shuffleClueBoxes()
    }

    static func getCategories() -> [Category] {
        return [
            Category(name: "Category0", boxTexts: ["Clue0", "Clue1", "Clue2", "Clue3"], colour: .yellow, id: 0),
            Category(name: "Category1", boxTexts: ["Clue4", "Clue5", "Clue6", "Clue7"], colour: .green, id: 1),
            Category(name: "Category2", boxTexts: ["Clue8", "Clue9", "Clue10", "Clue11"], colour: .blue, id: 2),
            Category(name: "Category3", boxTexts: ["Clue12", "Clue13", "Clue14", "Clue15"], colour: .purple, id: 3)
        ]
    }
    
    struct Category: Identifiable {
        @Observable
        class ClueBox: Identifiable {
            let text: String
            var isSelected: Bool = false
            let id: Int
            
            init(text: String, id: Int) {
                self.text = text
                self.id = id
            }
        }
        let name: String
        var clueBoxes: [ClueBox]
        let colour: Color
        var isCompleted: Bool
        let id: Int
        
        init(name: String, boxTexts: [String], colour: Color, id: Int) {
            self.name = name
            self.clueBoxes = ConnectionsGameModel.Category.createClueBoxes(boxTexts: boxTexts, offset: id)
            self.colour = colour
            self.isCompleted = false
            self.id = id
        }
        
        static func createClueBoxes(boxTexts: [String], offset: Int) -> [ClueBox] {
            var tmpClueBoxes: [ClueBox] = []
            for (i, boxText) in boxTexts.enumerated() {
                tmpClueBoxes.append(ClueBox(text: boxText, id: i+4*offset))
            }
            return tmpClueBoxes
        }
    }
    
    struct Guess {
        let clueBoxes: [Category.ClueBox]
        let correctCategoryID: Int?
        let oneAway: Bool
    }
    
    func clickClueBox(clueBox: Category.ClueBox) {
        if self.numSelectedBoxes < 4 || clueBox.isSelected {
            if let boxIndex = getClueBoxIndex(id: clueBox.id) {
                self.clueBoxes[boxIndex].isSelected.toggle()
            }
        }
    }
    
    func getClueBoxIndex(id: Int) -> Int? {
        return self.clueBoxes.firstIndex(where: { $0.id == id })
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
                completeCategory(categoryIndex: correctCategoryIndex)
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
        
        categoryLoop: for (categoryIndex, category) in self.remainingCategories.enumerated() {
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
        return Guess(clueBoxes: self.selectedBoxes, correctCategoryID: correctCategoryIndex, oneAway: oneAway)
    }
    
    func checkNumSameSelections(selectedIDs: [Int], categoryIDs: [Int]) -> Int {
        var numSameSelections: Int = 0
        for selectedID in selectedIDs {
            numSameSelections += (categoryIDs.contains(selectedID)) ? 1 : 0
        }
        return numSameSelections
    }
    
    func completeCategory(categoryIndex: Int) {
        let completedCategory: Category = self.remainingCategories.remove(at: categoryIndex)
        self.completedCategories.append(completedCategory)
    }
    
    func removeSelectedBoxes(selectedBoxIDs: [Int]) {
        for selectedBoxId in selectedBoxIDs {
            if let boxIndex = getClueBoxIndex(id: selectedBoxId) {
                self.clueBoxes.remove(at: boxIndex)
            }
        }
    }
    
    func activatePopup(popupText: String) {
        self.popupText = popupText
        self.popupTrigger.toggle()
    }

    func deselectAll() {
        if self.deselectAllIsClickable {
            for index in clueBoxes.indices {
                self.clueBoxes[index].isSelected = false
            }
        }
    }
    
    func shuffleClueBoxes() {
        self.clueBoxes.shuffle()
    }
    
    func resetNumMistakesRemaining() {
        self.numMistakesRemaining = 4
    }
    
    func startPlaying() {
        self.state = GameState.playing
    }
    
    func finishedPlaying() {
        self.state = GameState.finished
    }
    
    func resetGame() {
    }
}
