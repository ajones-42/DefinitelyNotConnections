//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

struct RemainingClueBoxes {
    let clueBoxes: [ClueBox]
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
        //shuffleClueBoxes()
        //deselectAllClueBoxes()
    }
    
    private func updateSingleClueBox(clueBoxes: [ClueBox], clueBoxID: Int, newClueBox: ClueBox) -> [ClueBox] {
        if let clueBoxIndex = clueBoxes.firstIndex(where: {$0.id == clueBoxID}) {
            var newClueBoxes: [ClueBox] = clueBoxes
            newClueBoxes[clueBoxIndex] = newClueBox
            return newClueBoxes
        } else {
            return self.clueBoxes
        }
    }

    func clickClueBox(clueBox: ClueBox) -> RemainingClueBoxes {
        if (self.numSelectedClueBoxes < 4 || clueBox.isSelected) {
            let newClueBoxes: [ClueBox] = updateSingleClueBox(clueBoxes: self.clueBoxes, clueBoxID: clueBox.id, newClueBox: clueBox.click())
            return RemainingClueBoxes(clueBoxes: newClueBoxes)
        } else {
            return self
        }
    }
    
    func shuffleClueBoxes() -> RemainingClueBoxes {
        var newClueBoxes: [ClueBox] = self.clueBoxes
        newClueBoxes.shuffle()
        return RemainingClueBoxes(clueBoxes: newClueBoxes)
    }
    
    func deselectAllClueBoxes() -> RemainingClueBoxes {
        var newClueBoxes: [ClueBox] = self.clueBoxes
        self.clueBoxes.forEach { clueBox in
            newClueBoxes.append(clueBox.isSelected ? clueBox.deselect() : clueBox)
        }
        return RemainingClueBoxes(clueBoxes: newClueBoxes)
    }
    
    func startShakingSelectedBoxes() -> RemainingClueBoxes {
        //TODO make this more efficient
        var newClueBoxes: [ClueBox] = self.clueBoxes
        self.selectedClueBoxes.forEach { clueBox in
            newClueBoxes = updateSingleClueBox(clueBoxes: newClueBoxes, clueBoxID: clueBox.id, newClueBox: clueBox.startShake())
        }
        return RemainingClueBoxes(clueBoxes: newClueBoxes)
    }
    
    func stopShakingSelectedBoxes() -> RemainingClueBoxes {
        //TODO make this more efficient
        var newClueBoxes: [ClueBox] = self.clueBoxes
        self.selectedClueBoxes.forEach { clueBox in
            newClueBoxes = updateSingleClueBox(clueBoxes: newClueBoxes, clueBoxID: clueBox.id, newClueBox: clueBox.stopShake())
        }
        return RemainingClueBoxes(clueBoxes: newClueBoxes)
    }
    
    /*func shakeSelectedBoxes() {
        self.selectedClueBoxes.forEach { clueBox in
            updateClueBoxInPlace(clueBoxID: clueBox.id, newClueBox: clueBox.startShake())
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.selectedClueBoxes.forEach { clueBox in
                self.updateClueBoxInPlace(clueBoxID: clueBox.id, newClueBox: clueBox.stopShake())
            }
        }
    }*/
    
    func removeSelectedClueBoxes() -> RemainingClueBoxes {
        var newClueBoxes: [ClueBox] = self.clueBoxes
        newClueBoxes.removeAll(where: { $0.isSelected })
        return RemainingClueBoxes(clueBoxes: newClueBoxes)
    }
}
