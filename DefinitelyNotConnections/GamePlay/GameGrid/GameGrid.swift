//
//  ConnectionsCategories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation

@Observable
class GameGrid {
    private(set) var allConnectionsCategories: ConnectionsCategories
    private(set) var allClueBoxes: AllClueBoxes
    let gameProperties: GameProperties
    
    init(setupInfo: SetupInfo, gameProperties: GameProperties) {
        self.allConnectionsCategories = ConnectionsCategories(setupInfo: setupInfo)
        self.gameProperties = gameProperties
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    init(allConnectionsCategories: ConnectionsCategories, allClueBoxes: AllClueBoxes, gameProperties: GameProperties) {
        self.allConnectionsCategories = allConnectionsCategories
        self.allClueBoxes = allClueBoxes
        self.gameProperties = gameProperties
    }
    
    func reset() {
        self.allConnectionsCategories.reset()
        self.allClueBoxes.reset()
    }
    
    func getSelectedRemainingClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.selectedRemainingClueBoxes
    }
    
    func getConnectionsCategories() -> [ConnectionsCategory] {
        return self.allConnectionsCategories.allConnectionsCategories
    }
    
    func getNumCompletedConnectionsCategories() -> Int {
        return self.allConnectionsCategories.numCompletedConnectionsCategories
    }
    
    func getSubmitIsClickable() -> Bool {
        return self.allClueBoxes.submitIsClickable
    }
    
    func shakeSelectedRemainingClueBoxesMomentarily(duration: TimeInterval) {
        self.allClueBoxes.shakeSelectedRemainingClueBoxesMomentarily(duration: duration)
    }
    
    func completeConnectionsCategory(connectionsCategoryID: UUID) throws {
        do {
            try self.allConnectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryID)
            try self.allClueBoxes.completeClueBoxesByConnectionsCategoryID(connectionsCategoryID: connectionsCategoryID)
        } catch {
            print("GameGrid.completeConnectionsCategory: Could not complete category with ID \(connectionsCategoryID).")
            throw error
        }
    }
}
