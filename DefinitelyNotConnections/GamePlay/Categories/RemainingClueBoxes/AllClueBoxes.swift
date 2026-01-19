//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

struct AllClueBoxes {
    let allClueBoxes: [ClueBox]
    var remainingClueBoxes: [ClueBox] {
        self.allClueBoxes.filter( {!$0.isCompleted} )
    }
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

    
    init(allClueBoxes: [ClueBox], shuffled: Bool) {
        self.allClueBoxes = shuffled ? allClueBoxes.shuffled() : allClueBoxes
    }
    
    init(categoryInfos: [CategoryInfo], shuffled: Bool) {
        let clueBoxes: [ClueBox] = categoryInfos.flatMap { catInfo in
            catInfo.clueInfos.map { clueInfo in
                ClueBox(clueInfo: clueInfo)
            }
        }
        self.allClueBoxes = shuffled ? clueBoxes.shuffled() : clueBoxes
    }
    
    func reset() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.map{clueBox in
            clueBox.reset()
        }
        return AllClueBoxes(allClueBoxes: newClueBoxes, shuffled: true)
    }
    
    func clickClueBox(clueBox: ClueBox) -> AllClueBoxes {
        if (self.numSelectedClueBoxes < 4 || clueBox.isSelected) {
            let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.id == clueBox.id}, withResultOf: {$0.click()})
            return AllClueBoxes(allClueBoxes: newClueBoxes, shuffled: false)
        } else {
            return self
        }
    }
    
    func shuffleClueBoxes() -> AllClueBoxes {
        return AllClueBoxes(allClueBoxes: self.allClueBoxes, shuffled: true)
    }
    
    func deselectAllClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.deselect()})
        return AllClueBoxes(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func startShakingSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.startShake()})
        return AllClueBoxes(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func stopShakingSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.stopShake()})
        return AllClueBoxes(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func completeSelectedClueBoxes() -> AllClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.setCompleted()})
        return AllClueBoxes(allClueBoxes: newClueBoxes, shuffled: true)
    }
}
