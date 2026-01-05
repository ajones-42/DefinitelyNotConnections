//
//  GameStateBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

class GameStateBuilder {
    var gamePhase: GamePhase = .playing
    var guesses: [Guess] = []
    
    func withGamePhase(gamePhase: GamePhase) -> GameStateBuilder {
        self.gamePhase = gamePhase
        return self
    }
    
    func withGuesses(guesses: [Guess]) -> GameStateBuilder {
        self.guesses = guesses
        return self
    }
    
    func build() -> GameState {
        return GameState(gamePhase: self.gamePhase, guesses: self.guesses)
    }
}
