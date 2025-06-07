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
    private(set) var clueBoxes: [ClueBox]
    var selectedBoxes: [ClueBox] {
        self.clueBoxes.filter { $0.isSelected == true }
    }
    var numSelectedBoxes: Int {
        self.selectedBoxes.count
    }
    var numMistakesRemaining: Int = 4
    
    init() {
        self.clueBoxes = []
        for (i, clueText) in ConnectionsGameModel.get_clues().enumerated() {
            self.clueBoxes.append(ClueBox(text: clueText, id: i))
        }
    }
    
    static func get_clues() -> [String] {
        return ["Clue0", "Clue1", "Clue2", "Clue3", "Clue4", "Clue5", "Clue6", "Clue7", "Clue8", "Clue9", "Clue10", "Clue11", "Clue12", "Clue13", "Clue14", "Clue15"]
    }
    
    struct ClueBox: Identifiable {
        var text: String
        var isSelected: Bool = false
        var isCompleted: Bool = false
        var id: Int
        
        mutating func unselect() {
            isSelected = false
        }
    }
    
    func clickBox(clueBox: ClueBox) {
        for index in clueBoxes.indices {
            if clueBoxes[index].id == clueBox.id {
                clueBoxes[index].isSelected.toggle()
            }
        }
    }
    
    func deselectAll() {
        for index in clueBoxes.indices {
            clueBoxes[index].isSelected = false
        }
    }
    
    func submit() {
        numMistakesRemaining -= 1
        deselectAll()
    }
}
