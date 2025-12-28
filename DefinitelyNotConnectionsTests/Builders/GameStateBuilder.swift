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
    var remainingClueBoxes: [ClueBox] = []
    
    func withGamePhase(gamePhase: GamePhase) -> GameStateBuilder {
        self.gamePhase = gamePhase
        return self
    }
    
    func withNumMistakesRemaining(numMistakesRemaining: Int) -> GameStateBuilder {
        self.numMistakesRemaining = numMistakesRemaining
        return self
    }
    
    func withCompletedCategories(completedCategories: [Category]) -> GameStateBuilder {
        self.completedCategories = completedCategories
        return self
    }
    
    func withGuesses(guesses: [Guess]) -> GameStateBuilder {
        self.guesses = guesses
        return self
    }
    
    func withRemainingClueBoxes(remainingClueBoxes: [ClueBox]) -> GameStateBuilder {
        self.remainingClueBoxes = remainingClueBoxes
        return self
    }
    
    func build() -> GameState {
        return GameState(gamePhase: self.gamePhase, numMistakesRemaining: self.numMistakesRemaining, completedCategories: self.completedCategories, guesses: self.guesses, remainingClueBoxes: RemainingClueBoxes(clueBoxes: self.remainingClueBoxes))
    }
}
