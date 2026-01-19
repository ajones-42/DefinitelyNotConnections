//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

struct RemainingClueBoxes {
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
    
    func reset() -> RemainingClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.map{clueBox in
            clueBox.reset()
        }
        return RemainingClueBoxes(allClueBoxes: newClueBoxes, shuffled: true)
    }
    
    func clickClueBox(clueBox: ClueBox) -> RemainingClueBoxes {
        if (self.numSelectedClueBoxes < 4 || clueBox.isSelected) {
            let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.id == clueBox.id}, withResultOf: {$0.click()})
            return RemainingClueBoxes(allClueBoxes: newClueBoxes, shuffled: false)
        } else {
            return self
        }
    }
    
    func shuffleClueBoxes() -> RemainingClueBoxes {
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, shuffled: true)
    }
    
    func deselectAllClueBoxes() -> RemainingClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.deselect()})
        return RemainingClueBoxes(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func startShakingSelectedClueBoxes() -> RemainingClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.startShake()})
        return RemainingClueBoxes(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func stopShakingSelectedClueBoxes() -> RemainingClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.stopShake()})
        return RemainingClueBoxes(allClueBoxes: newClueBoxes, shuffled: false)
    }
    
    func completeSelectedClueBoxes() -> RemainingClueBoxes {
        let newClueBoxes: [ClueBox] = self.allClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.setCompleted()})
        return RemainingClueBoxes(allClueBoxes: newClueBoxes, shuffled: true)
    }
}
