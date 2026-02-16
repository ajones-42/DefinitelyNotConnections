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

    var numRemainingClueBoxes: Int {
        self.remainingClueBoxes.count
    }

    var selectedRemainingClueBoxes: [ClueBox] {
        self.remainingClueBoxes.filter({ clueBox in
            clueBox.isSelected
        })
    }
    
    var selectedClueBoxIDs: [UUID] {
        getClueBoxIDs(clueBoxes: self.selectedRemainingClueBoxes)
    }
    
    var numSelectedRemainingClueBoxes: Int {
        self.selectedRemainingClueBoxes.count
    }
    
    var submitIsClickable: Bool {
        self.numSelectedRemainingClueBoxes == self.gameProperties.numCluesPerConnectionsCategory
    }
    
    var deselectAllIsClickable: Bool {
        self.numSelectedRemainingClueBoxes > 0
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
    
    private func clueBoxIsClickable(clueBox: ClueBox) -> Bool {
        return self.numSelectedRemainingClueBoxes < self.gameProperties.numCluesPerConnectionsCategory || clueBox.isSelected
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
    
    private func startShakingSelectedRemainingClueBoxes() {
        self.selectedRemainingClueBoxes.forEach({clueBox in
            clueBox.startShake()
        })
    }
    
    private func stopShakingSelectedRemainingClueBoxes() {
        self.selectedRemainingClueBoxes.forEach({clueBox in
            clueBox.stopShake()
        })
    }
    
    func shakeSelectedRemainingClueBoxesMomentarily(duration: TimeInterval) {
        startShakingSelectedRemainingClueBoxes()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.stopShakingSelectedRemainingClueBoxes()
        }
    }
    
    func completeClueBoxesByConnectionsCategoryID(connectionsCategoryID: UUID) throws {
        var completedAtLeastOneClueBox: Bool = false
        try self.allClueBoxes.forEach({clueBox in
            if clueBox.getConnectionsCategoryID() == connectionsCategoryID {
                if clueBox.isCompleted {
                    throw ValidationError.alreadyCompletedConnectionsCategory
                } else {
                    clueBox.setCompleted()
                    completedAtLeastOneClueBox = true
                }
            }
        })
        if !completedAtLeastOneClueBox {
            print("AllClueBoxes.completeClueBoxesByConnectionsCategoryID: Could not find any clue boxes with category ID \(connectionsCategoryID).")
            throw ValidationError.unknownConnectionsCategoryID
        }
    }
}
    
    
