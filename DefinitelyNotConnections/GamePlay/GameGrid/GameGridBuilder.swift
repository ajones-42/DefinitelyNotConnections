//
//  ConnectionsCategoriesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

// Add functions for testing
extension GameGrid {
    fileprivate func completeNConnectionsCategories(n: Int) throws {
        let allConnectionsCategoryIDs: [UUID] = self.allConnectionsCategories.getConnectionsCategoryIDs()
        let totalNumConnectionsCategories: Int = allConnectionsCategoryIDs.count
        guard (n >= 0 && n <= totalNumConnectionsCategories) else {
            print("GameGrid.completeNConnectionsCategories: n must be positive, and less than or equal to total number of clueBoxes (\(totalNumConnectionsCategories))")
            throw ValidationError.invalidInput
        }
        do {
            try allConnectionsCategoryIDs.enumerated().forEach({(index, connectionsCategoryID) in
                if index < n {
                    do {
                        try completeConnectionsCategory(connectionsCategoryID: connectionsCategoryID)
                    } catch {
                        throw error
                    }
                }
            })
        } catch {
            throw error
        }
    }
    
    fileprivate func completeAllConnectionsCategories() {
        let allConnectionsCategoryIDs: [UUID] = self.allConnectionsCategories.getConnectionsCategoryIDs()
        let totalNumConnectionsCategories: Int = allConnectionsCategoryIDs.count
        try! completeNConnectionsCategories(n: totalNumConnectionsCategories)
    }
}

class GameGridBuilder {
    var connectionsCategories: ConnectionsCategories
    var gameProperties: GameProperties
    var allClueBoxes: AllClueBoxes
    var numCompletedConnectionsCategories: Int = 0
    var completeAllConnectionsCategories: Bool = false
    var numSelectedClueBoxes: Int = 0
    var selectAllClueBoxes: Bool = false
    
    init(setupInfo: SetupInfo) {
        self.connectionsCategories = ConnectionsCategories(setupInfo: setupInfo)
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    init() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        self.connectionsCategories = ConnectionsCategories(setupInfo: setupInfo)
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    func withConnectionsCategories(connectionsCategories: ConnectionsCategories) -> GameGridBuilder {
        self.connectionsCategories = connectionsCategories
        return self
    }
    
    func withAllClueBoxes(allClueBoxes: AllClueBoxes) -> GameGridBuilder {
        self.allClueBoxes = allClueBoxes
        return self
    }
    
    func withGameProperties(gameProperties: GameProperties) -> GameGridBuilder {
        self.gameProperties = gameProperties
        return self
    }
    
    func withNCompletedConnectionsCategories(n: Int) throws -> GameGridBuilder {
        guard (self.completeAllConnectionsCategories == false) else {
            print("GameGridBuilder.withNCompletedConnectionsCategories: completeAllConnectionsCategories already set. Cannot use both in the same GameGridBuilder.")
            throw ValidationError.invalidInput
        }
        self.numCompletedConnectionsCategories = n
        return self
    }
    
    func withCompleteAllConnectionsCategories() throws -> GameGridBuilder {
        guard (self.numCompletedConnectionsCategories == 0) else {
            print("GameGridBuilder.withCompleteAllConnectionsCategories: numCompletedConnectionsCategories already set. Cannot use both in the same GameGridBuilder.")
            throw ValidationError.invalidInput
        }
        self.completeAllConnectionsCategories = true
        return self
    }
    
    func withNSelectedClueBoxes(n: Int) throws -> GameGridBuilder {
        guard (self.selectAllClueBoxes == false) else {
            print("GameGridBuilder.withNSelectedClueBoxes: selectAllClueBoxes already set. Cannot use both in the same GameGridBuilder.")
            throw ValidationError.invalidInput
        }
        self.numSelectedClueBoxes = n
        return self
    }
    
    func withSelectAllClueBoxes() throws -> GameGridBuilder {
        guard (self.numSelectedClueBoxes == 0) else {
            print("GameGridBuilder.withSelectAllClueBoxes: numSelectedClueBoxes already set. Cannot use both in the same GameGridBuilder.")
            throw ValidationError.invalidInput
        }
        self.selectAllClueBoxes = true
        return self
    }
    
    func build() -> GameGrid {
        let gameGrid: GameGrid = GameGrid(allConnectionsCategories: self.connectionsCategories, allClueBoxes: self.allClueBoxes, gameProperties: self.gameProperties)
        
        if self.completeAllConnectionsCategories {
            gameGrid.completeAllConnectionsCategories()
        } else if self.numCompletedConnectionsCategories > 0 {
            try! gameGrid.completeNConnectionsCategories(n: self.numCompletedConnectionsCategories)
        }

        if self.selectAllClueBoxes {
            gameGrid.allClueBoxes.selectAllClueBoxes()
        } else if self.numSelectedClueBoxes > 0 {
            try! gameGrid.allClueBoxes.selectNClueBoxes(n: self.numSelectedClueBoxes)
        }
        return gameGrid
    }
}
