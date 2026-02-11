//
//  ConnectionsCategoriesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

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
    
    func build() -> GameGrid {
        let gameGrid: GameGrid = GameGrid(allConnectionsCategories: self.connectionsCategories, allClueBoxes: self.allClueBoxes, gameProperties: self.gameProperties)
    }
}
