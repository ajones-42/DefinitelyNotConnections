//
//  ClueGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.12.25.
//

import Foundation

@Observable
class AllClueBoxes {
    var allClueBoxes: [ClueBox]
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
    
    func reset() {
        self.allClueBoxes = self.allClueBoxes.map({clueBox in
            clueBox.reset()
        })
    }
    
    func clueBoxIsClickable(clueBox: ClueBox) -> Bool {
        return self.numSelectedClueBoxes < self.gameProperties.numCluesPerCategory || clueBox.isSelected
    }
    
    func clickClueBox(clueBoxToClick: ClueBox) {
        if clueBoxIsClickable(clueBox: clueBoxToClick) {
            self.allClueBoxes = self.allClueBoxes.replaced(where: {clueBox in clueBox.getID() == clueBoxToClick.getID()}, withResultOf: {clueBox in clueBox.click()})
        }
    }
    
    func shuffleClueBoxes() {
        self.allClueBoxes.shuffle()
    }
    
    func deselectAllClueBoxes() {
        self.allClueBoxes = self.allClueBoxes.map({clueBox in
            clueBox.deselect()
        })
    }
    
    func startShakingSelectedClueBoxes() {
        self.allClueBoxes = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.startShake()})
    }
    
    func stopShakingSelectedClueBoxes() {
        self.allClueBoxes = self.allClueBoxes.map({clueBox in
            clueBox.stopShake()
        })
    }
    
    func completeSelectedClueBoxes() {
        self.allClueBoxes = self.allClueBoxes.replaced(where: {clueBox in clueBox.isSelected}, withResultOf: {clueBox in clueBox.setCompleted()})
    }
}
