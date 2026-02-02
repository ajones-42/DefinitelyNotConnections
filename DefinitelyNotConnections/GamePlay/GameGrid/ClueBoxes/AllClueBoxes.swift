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
    
    var selectedClueBoxIDs: [UUID] {
        getClueBoxIDs(clueBoxes: self.selectedClueBoxes)
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
        self.allClueBoxes.forEach({clueBox in
            clueBox.reset()
        })
    }
    
    private func getClueBoxIDs(clueBoxes: [ClueBox]) -> [UUID] {
        return clueBoxes.map({clueBox in
            clueBox.getID()
        })
    }
    
    func clueBoxIsClickable(clueBox: ClueBox) -> Bool {
        return self.numSelectedClueBoxes < self.gameProperties.numCluesPerCategory || clueBox.isSelected
    }
    
    func clickClueBox(clueBox: ClueBox) {
        if clueBoxIsClickable(clueBox: clueBox) {
            clueBox.click()
        }
    }
    
    func shuffleClueBoxes() {
        self.allClueBoxes.shuffle()
    }
    
    func deselectAllClueBoxes() {
        self.allClueBoxes.forEach({clueBox in
            clueBox.deselect()
        })
    }
    
    func startShakingSelectedClueBoxes() {
        self.selectedClueBoxes.forEach({clueBox in
            clueBox.startShake()
        })
    }
    
    func stopShakingSelectedClueBoxes() {
        self.selectedClueBoxes.forEach({clueBox in
            clueBox.stopShake()
        })
    }
    
    func completeClueBoxesByCategoryID(categoryID: UUID) {
        self.allClueBoxes.forEach({clueBox in
            if clueBox.getCategoryID() == categoryID {
                clueBox.setCompleted()
            }
        })
    }
}
