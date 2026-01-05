//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

@Observable
class RemainingClueBoxes {
    var clueBoxes: [ClueBox]
    
    //var selectedClueBoxes: [ClueBox] {
    //    self.clueBoxes.filter { $0.isSelected }
    //}
    
    init(clueBoxes: [ClueBox]) {
        self.clueBoxes = clueBoxes
        shuffleClueBoxes()
        deselectAllClueBoxes()
    }

    func clickClueBox(clueBox: ClueBox) {
        if (getNumSelectedClueBoxes() < 4 || clueBox.isSelected) {
            clueBox.click()
        }
    }
    
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.clueBoxes
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.clueBoxes.filter { $0.isSelected }
    }
    
    func getNumSelectedClueBoxes() -> Int {
        return getSelectedClueBoxes().count
    }
    
    func isSubmitClickable() -> Bool {
        return getNumSelectedClueBoxes() == 4
    }
    
    func shuffleClueBoxes() {
        self.clueBoxes.shuffle()
    }
    
    func isDeselectAllClickable() -> Bool {
        return getNumSelectedClueBoxes() > 0
    }
    
    func deselectAllClueBoxes() {
        for clueBox in self.clueBoxes {
            clueBox.deselect()
        }
    }
    
    func removeSelectedClueBoxes() {
        self.clueBoxes.removeAll(where: { $0.isSelected })
    }
}
