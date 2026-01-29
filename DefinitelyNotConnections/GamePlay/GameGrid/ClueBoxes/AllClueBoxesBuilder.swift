//
//  AllClueBoxesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class AllClueBoxesBuilder {
    var allClueBoxes: [ClueBox]
    var gameProperties: GameProperties
    var shuffled: Bool = true
    
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
    
    func build() -> AllClueBoxes {
        return AllClueBoxes(allClueBoxes: self.allClueBoxes, gameProperties: self.gameProperties, shuffled: self.shuffled)
    }
}
