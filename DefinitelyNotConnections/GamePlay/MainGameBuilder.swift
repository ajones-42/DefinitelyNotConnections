//
//  MainGameBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class MainGameBuilder {
    var gameProperties: GameProperties
    var gamePhase: GamePhase
    var gameGrid: GameGrid
    var allGuesses: AllGuesses
    var popup: Popup
    var mistakes: Mistakes
    
    init(setupInfo: SetupInfo) {
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.gamePhase = .setup
        self.gameGrid = GameGrid(setupInfo: setupInfo, gameProperties: self.gameProperties)
        self.allGuesses = AllGuesses()
        self.popup = Popup()
        self.mistakes = Mistakes(gameProperties: self.gameProperties)
    }
    
    init() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.gamePhase = .setup
        self.gameGrid = GameGrid(setupInfo: setupInfo, gameProperties: self.gameProperties)
        self.allGuesses = AllGuesses()
        self.popup = Popup()
        self.mistakes = Mistakes(gameProperties: self.gameProperties)
    }
    
    func withGameProperties(gameProperties: GameProperties) -> MainGameBuilder {
        self.gameProperties = gameProperties
        return self
    }
    
    func withGamePhase(gamePhase: GamePhase) -> MainGameBuilder {
        self.gamePhase = gamePhase
        return self
    }
    
    func withGameGrid(gameGrid: GameGrid) -> MainGameBuilder {
        self.gameGrid = gameGrid
        return self
    }
    
    func withAllGuesses(allGuesses: AllGuesses) -> MainGameBuilder {
        self.allGuesses = allGuesses
        return self
    }
    
    func withPopup(popup: Popup) -> MainGameBuilder {
        self.popup = popup
        return self
    }
    
    func withMistakes(mistakes: Mistakes) -> MainGameBuilder {
        self.mistakes =  mistakes
        return self
    }
    
    func build() -> MainGame {
        return MainGame(gameProperties: self.gameProperties, gamePhase: self.gamePhase, gameGrid: self.gameGrid, allGuesses: self.allGuesses, popup: self.popup, mistakes: self.mistakes)
    }
}
