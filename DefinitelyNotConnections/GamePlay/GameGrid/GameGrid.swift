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
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.selectedClueBoxes
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
    
    func shakeSelectedClueBoxesMomentarily(duration: TimeInterval) {
        self.allClueBoxes.shakeSelectedClueBoxesMomentarily(duration: duration)
    }
    
    func completeConnectionsCategory(connectionsCategoryID: UUID) {
        self.allConnectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryID)
        self.allClueBoxes.completeClueBoxesByConnectionsCategoryID(connectionsCategoryID: connectionsCategoryID)
    }
}
