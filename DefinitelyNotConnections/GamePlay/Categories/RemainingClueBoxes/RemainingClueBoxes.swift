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
    }
    
    init(allClueBoxes: [ClueBox], shuffled: Bool) {
        self.allClueBoxes = allClueBoxes
        if shuffled {
            self.remainingClueBoxes = allClueBoxes.shuffled()
        } else {
            self.remainingClueBoxes = allClueBoxes
        }
    }
    
    init(categoryInfos: [CategoryInfo], shuffled: Bool) {
        let clueBoxes: [ClueBox] = categoryInfos.enumerated().flatMap { (catindex, catInfo) in
            catInfo.clues.enumerated().map { (clueindex, clue) in
                    ClueBox(text: clue)
            }
        }
        self.allClueBoxes = clueBoxes
        if shuffled {
            self.remainingClueBoxes = clueBoxes.shuffled()
        } else {
            self.remainingClueBoxes = clueBoxes
        }
    }
    
    init(allClueBoxes: [ClueBox], remainingClueBoxes: [ClueBox]) {
        self.allClueBoxes = allClueBoxes
        self.remainingClueBoxes = remainingClueBoxes
    }
    
    func reset() -> RemainingClueBoxes {
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, shuffled: true)
    }
    
    func clickClueBox(clueBox: ClueBox) -> RemainingClueBoxes {
        if (self.numSelectedClueBoxes < 4 || clueBox.isSelected) {
            let newClueBoxes: [ClueBox] = self.remainingClueBoxes.replaced(where: {$0.id == clueBox.id}, withResultOf: {$0.click()})
            return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
        } else {
            return self
        }
    }
    
    func shuffleClueBoxes() -> RemainingClueBoxes {
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: self.remainingClueBoxes, shuffled: true)
    }
    
    func deselectAllClueBoxes() -> RemainingClueBoxes {
        let newClueBoxes: [ClueBox] = self.remainingClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.deselect()})
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
    }
    
    func startShakingSelectedClueBoxes() -> RemainingClueBoxes {
        let newClueBoxes: [ClueBox] = self.remainingClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.startShake()})
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
    }
    
    func stopShakingSelectedClueBoxes() -> RemainingClueBoxes {
        let newClueBoxes: [ClueBox] = self.remainingClueBoxes.replaced(where: {$0.isSelected}, withResultOf: {$0.stopShake()})
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
    }
    
    func removeSelectedClueBoxes() -> RemainingClueBoxes {
        var newClueBoxes: [ClueBox] = self.remainingClueBoxes
        newClueBoxes.removeAll(where: { $0.isSelected })
        return RemainingClueBoxes(allClueBoxes: self.allClueBoxes, remainingClueBoxes: newClueBoxes)
    }
}
