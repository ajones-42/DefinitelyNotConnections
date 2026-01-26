//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

struct AllClueBoxes {
    let allClueBoxes: [ClueBox]
    let gameProperties: GameProperties

    var remainingClueBoxes: [ClueBox] {
        self.allClueBoxes.filter({clueBox in
            !clueBox.isCompleted
        })
    }
    var selectedClueBoxes: [ClueBox] {
        self.remainingClueBoxes.filter({ clueBox in
            clueBox.isSelected
        })
    }
    
    var numSelectedClueBoxes: Int {
        self.selectedClueBoxes.count
    }
    
    var submitIsClickable: Bool {
        self.numSelectedClueBoxes == self.gameProperties.numCluesPerCategory
    }
    
    var deselectAllIsClickable: Bool {
        self.numSelectedClueBoxes > 0
    }
    

    init(setupInfo: SetupInfo, gameProperties: GameProperties, shuffled: Bool) {
        let clueBoxes: [ClueBox] = createClueBoxes(setupInfo: setupInfo)
        self.allClueBoxes = shuffled ? clueBoxes.shuffled() : clueBoxes
        self.gameProperties = gameProperties
    }
    
    init(allClueBoxes: [ClueBox], gameProperties: GameProperties, shuffled: Bool) {
        self.allClueBoxes = shuffled ? allClueBoxes.shuffled() : allClueBoxes
        self.gameProperties = gameProperties
    }
    
    func reset() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.map{clueBox in
            clueBox.reset()
        }
        return recompute(allClueBoxes: newClueBoxes, shuffled: true)
    }
    
    private func recompute(allClueBoxes: [ClueBox], shuffled: Bool) -> AllClueBoxes {
        return AllClueBoxes(allClueBoxes: allClueBoxes, gameProperties: self.gameProperties, shuffled: shuffled)
    }
    
    func clueBoxIsClickable(clueBox: ClueBox) -> Bool {
        return self.numSelectedClueBoxes < self.gameProperties.numCluesPerCategory || clueBox.isSelected
    }
    
    func clickClueBox(clueBoxToClick: ClueBox) -> AllClueBoxes {
        if clueBoxIsClickable(clueBox: clueBoxToClick) {
            let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.getID() == clueBoxToClick.getID()}, withResultOf: {clueBox in clueBox.click()})
            return recompute(allClueBoxes: newClueBoxes, shuffled: false)
        } else {
            return self
        }
    }
    
    func shuffleClueBoxes() -> AllClueBoxes {
        return recompute(allClueBoxes: self.allClueBoxes, shuffled: true)
    }
    
    func deselectAllClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.deselect()})
        return recompute(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func startShakingSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.startShake()})
        return recompute(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func stopShakingSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.stopShake()})
        return recompute(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func completeSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.setCompleted()})
        return recompute(allClueBoxes: newClueBoxes, shuffled: true)
    }
}
