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
    
    private(set) var clueBoxes: [ClueBox]
    var selectedBoxes: [ClueBox] {
        self.clueBoxes.filter { $0.isSelected == true }
    }
    var numSelectedBoxes: Int {
        self.selectedBoxes.count
    }
    var numMistakesRemaining: Int = 4
    
    init() {
        self.categories = ConnectionsGameModel.getCategories()
        self.clueBoxes = ConnectionsGameModel.getClues()
    }
    
    static func getClues() -> [ClueBox] {
        return [ClueBox(text: "Clue0", id: 0), ClueBox(text: "Clue1", id: 1), ClueBox(text: "Clue2", id: 2), ClueBox(text: "Clue3", id: 3), ClueBox(text: "Clue4", id: 4), ClueBox(text: "Clue5", id: 5), ClueBox(text: "Clue6", id: 6), ClueBox(text: "Clue7", id: 7), ClueBox(text: "Clue8", id: 8), ClueBox(text: "Clue9", id: 9), ClueBox(text: "Clue10", id: 10), ClueBox(text: "Clue11", id: 11), ClueBox(text: "Clue12", id: 12), ClueBox(text: "Clue13", id: 13), ClueBox(text: "Clue14", id: 14), ClueBox(text: "Clue15", id: 15)]
    }
    
    static func getCategories() -> [Category] {
        return [Category(name: "Category0", boxIDs: [0,1,2,3], boxTexts: ["Clue0", "Clue1", "Clue2", "Clue3"], colour: .yellow, id: 0), Category(name: "Category1", boxIDs: [4,5,6,7], boxTexts: ["Clue4", "Clue5", "Clue6", "Clue7"], colour: .green, id: 1), Category(name: "Category2", boxIDs: [8,9,10,11], boxTexts: ["Clue8", "Clue9", "Clue10", "Clue11"], colour: .blue, id: 2), Category(name: "Category3", boxIDs: [12,13,14,15], boxTexts: ["Clue12", "Clue13", "Clue14", "Clue15"], colour: .purple, id: 3)]
    }
    
    struct ClueBox: Identifiable {
        let text: String
        var isSelected: Bool = false
        var isCompleted: Bool = false
        let id: Int
    }
    
    struct Category: Identifiable {
        let name: String
        let boxIDs: [Int]
        let boxTexts: [String]
        let colour: Color
        var isCompleted: Bool = false
        let id: Int
        
        func concatBoxTexts() -> String {
            return boxTexts.joined(separator: ", ")
        }
    }
    
    func getClueBoxIndex(id: Int) -> Int? {
        return clueBoxes.firstIndex(where: { $0.id == id })
    }
    
    func clickBox(clueBox: ClueBox) {
        if let boxIndex = getClueBoxIndex(id: clueBox.id) {
            clueBoxes[boxIndex].isSelected.toggle()
        }
    }
    
    func submit() {
        checkSelection()
        deselectAll()
    }
    
    func checkSelection() {
        // This might be easier if clueBoxes: Set<ClueBox>, but then toggling isSelected can't be done as it is now.
        // Probably wants some factoring out
        var correct: Bool = false
        for categoryIndex in categories.indices {
            let selectedBoxIDs: [Int] = selectedBoxes.map({ $0.id }).sorted()
            if selectedBoxIDs == categories[categoryIndex].boxIDs.sorted() {
                correct.toggle()
                categories[categoryIndex].isCompleted = true
                for selectedBoxId in selectedBoxIDs {
                    if let boxIndex = getClueBoxIndex(id: selectedBoxId) {
                        clueBoxes.remove(at: boxIndex)
                    }
                }
            break
            }
        }
        if !correct { numMistakesRemaining -= 1 }
    }
    
    func deselectAll() {
        for index in clueBoxes.indices {
            clueBoxes[index].isSelected = false
        }
    }
}
