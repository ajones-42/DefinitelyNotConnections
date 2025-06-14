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
    private(set) var categories: [Category]
    private(set) var completedCategories: [Category] = []
    
    private(set) var clueBoxes: [Category.ClueBox]
    var selectedBoxes: [Category.ClueBox] {
        self.clueBoxes.filter { $0.isSelected == true }
    }
    var numSelectedBoxes: Int {
        self.selectedBoxes.count
    }
    var numMistakesRemaining: Int = 4
    
    init() {
        self.categories = ConnectionsGameModel.getCategories()
        self.clueBoxes = []
        for category in categories {
            self.clueBoxes.append(contentsOf: category.clueBoxes)
        }
        shuffleClueBoxes()
    }

    static func getCategories() -> [Category] {
        return [Category(name: "Category0", boxTexts: ["Clue0", "Clue1", "Clue2", "Clue3"], colour: .yellow, id: 0), Category(name: "Category1", boxTexts: ["Clue4", "Clue5", "Clue6", "Clue7"], colour: .green, id: 1), Category(name: "Category2", boxTexts: ["Clue8", "Clue9", "Clue10", "Clue11"], colour: .blue, id: 2), Category(name: "Category3", boxTexts: ["Clue12", "Clue13", "Clue14", "Clue15"], colour: .purple, id: 3)]
    }
    
    struct Category: Identifiable {
        @Observable
        class ClueBox: Identifiable {
            let text: String
            var isSelected: Bool = false {
                willSet {
                    print("Selected \(id)")
                }
            }
            let id: Int
            
            init(text: String, id: Int) {
                self.text = text
                self.id = id
            }
        }
        let name: String
        var clueBoxes: [ClueBox]
        let colour: Color
        let id: Int
        
        init(name: String, boxTexts: [String], colour: Color, id: Int) {
            self.name = name
            self.clueBoxes = ConnectionsGameModel.Category.createClueBoxes(boxTexts: boxTexts, offset: id)
            self.colour = colour
            self.id = id
        }
        
        static func createClueBoxes(boxTexts: [String], offset: Int) -> [ClueBox] {
            var tmpClueBoxes: [ClueBox] = []
            for (i, boxText) in boxTexts.enumerated() {
                tmpClueBoxes.append(ClueBox(text: boxText, id: i+4*offset))
            }
            return tmpClueBoxes
        }
        
        func concatBoxTexts() -> String {
            let boxTexts = clueBoxes.map({ $0.text })
            return boxTexts.joined(separator: ", ")
        }
    }
    
    func getClueBoxIndex(id: Int) -> Int? {
        return clueBoxes.firstIndex(where: { $0.id == id })
    }
    
    func clickBox(clueBox: Category.ClueBox) {
        if let boxIndex = getClueBoxIndex(id: clueBox.id) {
            clueBoxes[boxIndex].isSelected.toggle()
        }
    }
    
    func submit() {
        checkSelection()
        deselectAll()
    }
    
    func checkSelection() {
        var correct: Bool = false
        let selectedBoxIDs: [Int] = selectedBoxes.map({ $0.id })
        for (categoryIndex, category) in categories.enumerated() {
            let numSameSelections: Int = checkNumSameSelections(selectedIDs: selectedBoxIDs, categoryIDs: category.clueBoxes.map({$0.id}))
            switch numSameSelections {
            case 4:
                completeCategory(categoryIndex: categoryIndex)
                removeSelectedBoxes(selectedBoxIDs: selectedBoxIDs)
                correct = true
                break
            case 3:
                // One away
                break
            case 2:
                // No need to check further if 2 are correct
                break
            default:
                // Keep checking for 0 or 1 correct
                continue
            }
        }
        if !correct { numMistakesRemaining -= 1 }
    }
    
    func checkNumSameSelections(selectedIDs: [Int], categoryIDs: [Int]) -> Int {
        let sortedSelectedIDs = selectedIDs.sorted()
        let sortedCategoryIDs = categoryIDs.sorted()
        var numSameSelections: Int = 0
        for (index, ID) in sortedSelectedIDs.enumerated() {
            numSameSelections += (sortedCategoryIDs[index] == ID) ? 1 : 0
        }
        return numSameSelections
    }
    
    func completeCategory(categoryIndex: Int) {
        let completedCategory: Category = categories.remove(at: categoryIndex)
        completedCategories.append(completedCategory)
    }
    
    func removeSelectedBoxes(selectedBoxIDs: [Int]) {
        for selectedBoxId in selectedBoxIDs {
            if let boxIndex = getClueBoxIndex(id: selectedBoxId) {
                clueBoxes.remove(at: boxIndex)
            }
        }
    }
    
    func deselectAll() {
        for index in clueBoxes.indices {
            clueBoxes[index].isSelected = false
        }
    }
    
    func shuffleClueBoxes() {
        self.clueBoxes.shuffle()
    }
    
    func resetNumMistakesRemaining() {
        self.numMistakesRemaining = 4
    }
}
