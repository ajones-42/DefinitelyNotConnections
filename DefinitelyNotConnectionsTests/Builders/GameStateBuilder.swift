//
//  GameStateBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

class GameStateBuilder {
    var gamePhase: GamePhase = .playing
    var numMistakesRemaining: Int = 4
    var completedCategories: [Category] = []
    var guesses: [Guess] = []
    
    func withGamePhase(gamePhase: GamePhase) -> GameStateBuilder {
        self.gamePhase = gamePhase
        return self
    }
    
    func withNumMistakesRemaining(numMistakesRemaining: Int) -> GameStateBuilder {
        self.numMistakesRemaining = numMistakesRemaining
        return self
    }
    
    func withGuesses(guesses: [Guess]) -> GameStateBuilder {
        self.guesses = guesses
        return self
    }
    
    func build() -> GameState {
        return GameState(gamePhase: self.gamePhase, numMistakesRemaining: self.numMistakesRemaining, guesses: self.guesses)
    }
}
