//
//  ConnectionsCategoriesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class GameGridBuilder {
    var categories: ConnectionsCategories
    var gameProperties: GameProperties
    var allClueBoxes: AllClueBoxes
    
    init(setupInfo: SetupInfo) {
        self.categories = ConnectionsCategories(setupInfo: setupInfo)
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    init() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        self.categories = ConnectionsCategories(setupInfo: setupInfo)
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    func withConnectionsCategories(categories: ConnectionsCategories) -> GameGridBuilder {
        self.categories = categories
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
        return GameGrid(allConnectionsCategories: self.categories, allClueBoxes: self.allClueBoxes, gameProperties: self.gameProperties)
    }
}
