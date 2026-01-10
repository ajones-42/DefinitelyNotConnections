//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

struct RemainingClueBoxes {
    let allClueBoxes: [ClueBox]
    let remainingClueBoxes: [ClueBox]
    var selectedClueBoxes: [ClueBox] {
        self.remainingClueBoxes.filter( {$0.isSelected} )
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

    
    init(allClueBoxes: [ClueBox], remainingClueBoxes: [ClueBox], shuffled: Bool) {
        self.allClueBoxes = allClueBoxes
        if shuffled {
            self.remainingClueBoxes = remainingClueBoxes.shuffled()
        } else {
            self.remainingClueBoxes = remainingClueBoxes
        }
        //deselectAllClueBoxes()
    }
    
    init(allClueBoxes: [ClueBox], shuffled: Bool) {
        self.allClueBoxes = allClueBoxes
        if shuffled {
            self.remainingClueBoxes = allClueBoxes.shuffled()
        } else {
            self.remainingClueBoxes = allClueBoxes
        }
        //deselectAllClueBoxes()
    }
    
    init(allClueBoxes: [ClueBox], remainingClueBoxes: [ClueBox]) {
        self.allClueBoxes = allClueBoxes
        self.remainingClueBoxes = remainingClueBoxes
    }
    
    /*init(allClueBoxes: [ClueBox]) {
        self.allClueBoxes = allClueBoxes
        self.remainingClueBoxes = allClueBoxes
    }*/
    
    func reset() -> RemainingClueBoxes {
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, shuffled: true)
    }
    
    private func updateSingleClueBox(clueBoxes: [ClueBox], clueBoxID: Int, newClueBox: ClueBox) -> [ClueBox] {
        if let clueBoxIndex = clueBoxes.firstIndex(where: {$0.id == clueBoxID}) {
            var newClueBoxes: [ClueBox] = clueBoxes
            newClueBoxes[clueBoxIndex] = newClueBox
            return newClueBoxes
        } else {
            return self.remainingClueBoxes
        }
    }

    func clickClueBox(clueBox: ClueBox) -> RemainingClueBoxes {
        if (self.numSelectedClueBoxes < 4 || clueBox.isSelected) {
            let newClueBoxes: [ClueBox] = updateSingleClueBox(clueBoxes: self.remainingClueBoxes, clueBoxID: clueBox.id, newClueBox: clueBox.click())
            return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
        } else {
            return self
        }
    }
    
    func shuffleClueBoxes() -> RemainingClueBoxes {
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: self.remainingClueBoxes, shuffled: true)
    }
    
    func deselectAllClueBoxes() -> RemainingClueBoxes {
        var newClueBoxes: [ClueBox] = []
        self.remainingClueBoxes.forEach { clueBox in
            newClueBoxes.append(clueBox.isSelected ? clueBox.deselect() : clueBox)
        }
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
    }
    
    func startShakingSelectedBoxes() -> RemainingClueBoxes {
        var newClueBoxes: [ClueBox] = []
        self.remainingClueBoxes.forEach { clueBox in
            newClueBoxes.append(selectedClueBoxes.contains(clueBox) ? clueBox.startShake() : clueBox)
        }
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
    }
    
    func stopShakingSelectedBoxes() -> RemainingClueBoxes {
        var newClueBoxes: [ClueBox] = []
        self.remainingClueBoxes.forEach { clueBox in
            newClueBoxes.append(selectedClueBoxes.contains(clueBox) ? clueBox.stopShake() : clueBox)
        }
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
    }
    
    func removeSelectedClueBoxes() -> RemainingClueBoxes {
        var newClueBoxes: [ClueBox] = self.remainingClueBoxes
        newClueBoxes.removeAll(where: { $0.isSelected })
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
    }
}
