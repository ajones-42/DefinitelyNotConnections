//
//  AllClueBoxesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

// Add functions for testing
extension AllClueBoxes {
    fileprivate func completeNClueBoxes(n: Int) throws {
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
    
    fileprivate func completeAllClueBoxes() {
        let totalNumClueBoxes: Int = self.allClueBoxes.count
        try! completeNClueBoxes(n: totalNumClueBoxes)
    }
    
    // These can't be fileprivate or GameGrid(Builder) has to reimplement them
    internal func selectNClueBoxes(n: Int) throws {
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
    
    internal func selectAllClueBoxes() {
        let totalNumClueBoxes: Int = self.allClueBoxes.count
        try! selectNClueBoxes(n: totalNumClueBoxes)
    }
}

class AllClueBoxesBuilder {
    var allClueBoxes: [ClueBox]
    var gameProperties: GameProperties
    var shuffled: Bool = true
    var numCompletedClueBoxes: Int = 0
    var completeAllClueBoxes: Bool = false
    var numSelectedClueBoxes: Int = 0
    var selectAllClueBoxes: Bool = false
    
    init(setupInfo: SetupInfo) {
        self.allClueBoxes = createClueBoxes(setupInfo: setupInfo)
        self.gameProperties = GameProperties(setupInfo: setupInfo)
    }
    
    init() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        self.allClueBoxes = createClueBoxes(setupInfo: setupInfo)
        self.gameProperties = GameProperties(setupInfo: setupInfo)
    }
    
    func withAllClueBoxes(allClueBoxes: [ClueBox]) -> AllClueBoxesBuilder {
        self.allClueBoxes = allClueBoxes
        return self
    }
    
    func withGameProperties(gameProperties: GameProperties) -> AllClueBoxesBuilder {
        self.gameProperties = gameProperties
        return self
    }
    
    func withShuffled(shuffled: Bool) -> AllClueBoxesBuilder {
        self.shuffled = shuffled
        return self
    }
    
    func withNCompletedClueBoxes(n: Int) throws -> AllClueBoxesBuilder {
        guard (self.completeAllClueBoxes == false) else {
            print("AllClueBoxesBuilder.withNCompletedClueBoxes: completeAllClueBoxes already set. Cannot use both in the same AllClueBoxesBuilder.")
            throw ValidationError.invalidInput
        }
        self.numCompletedClueBoxes = n
        return self
    }
    
    func withCompleteAllClueBoxes() throws -> AllClueBoxesBuilder {
        guard (self.numCompletedClueBoxes == 0) else {
            print("AllClueBoxesBuilder.withCompleteAllClueBoxes: numCompletedClueBoxes already set. Cannot use both in the same AllClueBoxesBuilder.")
            throw ValidationError.invalidInput
        }
        self.completeAllClueBoxes = true
        return self
    }
    
    func withNSelectedClueBoxes(n: Int) throws -> AllClueBoxesBuilder {
        guard (self.selectAllClueBoxes == false) else {
            print("AllClueBoxesBuilder.withNSelectedClueBoxes: selectAllClueBoxes already set. Cannot use both in the same AllClueBoxesBuilder.")
            throw ValidationError.invalidInput
        }
        self.numSelectedClueBoxes = n
        return self
    }
    
    func withSelectAllClueBoxes() throws -> AllClueBoxesBuilder {
        guard (self.numSelectedClueBoxes == 0) else {
            print("AllClueBoxesBuilder.withSelectAllClueBoxes: numSelectedClueBoxes already set. Cannot use both in the same AllClueBoxesBuilder.")
            throw ValidationError.invalidInput
        }
        self.selectAllClueBoxes = true
        return self
    }
    
    // Crash on failure rather than require callers to handle error
    func build() -> AllClueBoxes {
        let allClueBoxes: AllClueBoxes = AllClueBoxes(allClueBoxes: self.allClueBoxes, gameProperties: self.gameProperties, shuffled: self.shuffled)

        if self.completeAllClueBoxes {
            allClueBoxes.completeAllClueBoxes()
        } else if self.numCompletedClueBoxes > 0 {
            try! allClueBoxes.completeNClueBoxes(n: self.numCompletedClueBoxes)
        }

        if self.selectAllClueBoxes {
            allClueBoxes.selectAllClueBoxes()
        } else if self.numSelectedClueBoxes > 0 {
            try! allClueBoxes.selectNClueBoxes(n: self.numSelectedClueBoxes)
        }

        return allClueBoxes
        
    }
}
