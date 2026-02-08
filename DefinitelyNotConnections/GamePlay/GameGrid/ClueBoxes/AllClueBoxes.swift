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
        self.numSelectedClueBoxes == self.gameProperties.numCluesPerConnectionsCategory
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
    
    private func clueBoxIsClickable(clueBox: ClueBox) -> Bool {
        return self.numSelectedClueBoxes < self.gameProperties.numCluesPerConnectionsCategory || clueBox.isSelected
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
    
    private func startShakingSelectedClueBoxes() {
        self.selectedClueBoxes.forEach({clueBox in
            clueBox.startShake()
        })
    }
    
    private func stopShakingSelectedClueBoxes() {
        self.selectedClueBoxes.forEach({clueBox in
            clueBox.stopShake()
        })
    }
    
    func shakeSelectedClueBoxesMomentarily(duration: TimeInterval) {
        startShakingSelectedClueBoxes()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.stopShakingSelectedClueBoxes()
        }
    }
    
    func completeClueBoxesByConnectionsCategoryID(connectionsCategoryID: UUID) {
        self.allClueBoxes.forEach({clueBox in
            if clueBox.getConnectionsCategoryID() == connectionsCategoryID {
                clueBox.setCompleted()
            }
        })
    }
}

// Add functions for testing
extension AllClueBoxes {
    private func completeNClueBoxes(n: Int) throws {
        let totalNumClueBoxes: Int = self.allClueBoxes.count
        guard (n >= 0 && n <= totalNumClueBoxes) else {
            print("AllClueBoxes.completeNClueBoxes: n must be positive, and less than or equal to total number of clueBoxes (\(totalNumClueBoxes))")
            throw ValidationError.invalidInput
        }
        self.allClueBoxes.enumerated().forEach({(index, clueBox) in
            if index < n {
                clueBox.setCompleted()
            }
        })
    }
    
    private func selectNClueBoxes(n: Int) throws {
        let totalNumClueBoxes: Int = self.allClueBoxes.count
        guard (n >= 0 && n <= totalNumClueBoxes && n <= self.gameProperties.numCluesPerConnectionsCategory) else {
            print("AllClueBoxes.selectNClueBoxes: n must be positive, less than or equal to total number of clueBoxes (\(totalNumClueBoxes)), and less than or equal to the number of clues per category \(self.gameProperties.numCluesPerConnectionsCategory).")
            throw ValidationError.invalidInput
        }
        self.allClueBoxes.enumerated().forEach({(index, clueBox) in
            if index < n {
                clueBox.select()
            }
        })
    }
}
    
    
