//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

class RemainingClueBoxes {
    var clueBoxes: [ClueBox]
    
    //var selectedClueBoxes: [ClueBox] {
    //    self.clueBoxes.filter { $0.isSelected }
    //}
    
    init(clueBoxes: [ClueBox]) {
        self.clueBoxes = clueBoxes
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.clueBoxes.filter { $0.isSelected }
    }
    
    func getNumSelectedBoxes() -> Int {
        return getSelectedClueBoxes().count
    }
    
    func shuffle() {
        self.clueBoxes.shuffle()
    }
    
    func deselectAll() {
        for clueBox in self.clueBoxes {
            clueBox.deselect()
        }
    }
    
    func removeSelectedClueBoxes() {
        self.clueBoxes.removeAll(where: { $0.isSelected })
    }
}
