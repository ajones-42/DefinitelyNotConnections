//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

struct AllClueBoxes {
    let allClueBoxes: [ClueBox]
    let numCluesPerCategory: Int
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
        self.numSelectedClueBoxes == self.numCluesPerCategory
    }
    
    var deselectAllIsClickable: Bool {
        self.numSelectedClueBoxes > 0
    }
    

    init(setupInfo: SetupInfo, shuffled: Bool) {
        self.numCluesPerCategory = setupInfo.numCluesPerCategory
        let clueBoxes: [ClueBox] = setupInfo.categoryInfos.flatMap { catInfo in
            catInfo.clueInfos.map { clueInfo in
                ClueBox(clueInfo: clueInfo)
            }
        }
        self.allClueBoxes = shuffled ? clueBoxes.shuffled() : clueBoxes
    }
    
    init(allClueBoxes: [ClueBox], numCluesPerCategory: Int, shuffled: Bool) {
        self.numCluesPerCategory = numCluesPerCategory
        self.allClueBoxes = shuffled ? allClueBoxes.shuffled() : allClueBoxes
    }
    
    func reset() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.map{clueBox in
            clueBox.reset()
        }
        return AllClueBoxes(allClueBoxes: newClueBoxes, numCluesPerCategory: self.numCluesPerCategory, shuffled: true)
    }
    
    func clickClueBox(clueBox: ClueBox) -> AllClueBoxes {
        if (self.numSelectedClueBoxes < 4 || clueBox.isSelected) {
            let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.getID() == clueBox.getID()}, withResultOf: {clueBox in clueBox.click()})
            return AllClueBoxes(allClueBoxes: newClueBoxes, numCluesPerCategory: self.numCluesPerCategory, shuffled: false)
        } else {
            return self
        }
    }
    
    func shuffleClueBoxes() -> AllClueBoxes {
        return AllClueBoxes(allClueBoxes: self.allClueBoxes, numCluesPerCategory: self.numCluesPerCategory, shuffled: true)
    }
    
    func deselectAllClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.deselect()})
        return AllClueBoxes(allClueBoxes: newClueBoxes, numCluesPerCategory: self.numCluesPerCategory, shuffled: false)
    }
    
    func startShakingSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.startShake()})
        return AllClueBoxes(allClueBoxes: newClueBoxes, numCluesPerCategory: self.numCluesPerCategory, shuffled: false)
    }
    
    func stopShakingSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.stopShake()})
        return AllClueBoxes(allClueBoxes: newClueBoxes, numCluesPerCategory: self.numCluesPerCategory, shuffled: false)
    }
    
    func completeSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.setCompleted()})
        return AllClueBoxes(allClueBoxes: newClueBoxes, numCluesPerCategory: self.numCluesPerCategory, shuffled: true)
    }
}
