//
//  GameStateBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

class GameStateBuilder {
    var gamePhase: GamePhase = .playing
    
    func withGamePhase(gamePhase: GamePhase) -> GameStateBuilder {
        self.gamePhase = gamePhase
        return self
    }
    
    func build() -> GameState {
        return GameState(gamePhase: self.gamePhase)
    }
}
