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
    var selectedClueBoxes: [ClueBox] {
        self.clueBoxes.filter( {$0.isSelected} )
    }
    
    var numSelectedClueBoxes: Int {
        self.selectedClueBoxes.count
    }
    
    var submitIsClickable: Bool {
        self.numSelectedClueBoxes == 4
    }
    
    var deselectAllIsClickable: Bool {
        self.numSelectedClueBoxes > 0
    }

    
    init(clueBoxes: [ClueBox]) {
        self.clueBoxes = clueBoxes
        shuffleClueBoxes()
        deselectAllClueBoxes()
    }

    func clickClueBox(clueBox: ClueBox) {
        if (self.numSelectedClueBoxes < 4 || clueBox.isSelected) {
            clueBox.click()
        }
    }
    
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.clueBoxes
    }
    
    func shuffleClueBoxes() {
        self.clueBoxes.shuffle()
    }
    
    func deselectAllClueBoxes() {
        for clueBox in self.clueBoxes {
            clueBox.deselect()
        }
    }
    
    func shakeSelectedBoxes() {
        self.selectedClueBoxes.forEach { box in
            box.startShake()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.selectedClueBoxes.forEach { box in
                box.stopShake()
            }
        }
    }
    
    func removeSelectedClueBoxes() {
        self.clueBoxes.removeAll(where: { $0.isSelected })
    }
}
