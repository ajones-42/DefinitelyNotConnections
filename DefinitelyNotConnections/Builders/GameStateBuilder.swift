//
//  GameStateBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

struct GameStateBuilder {
    var gamePhase: GamePhase = .playing
    var numMistakesRemaining: Int = 4
    var completedCategories: [Category] = []
    var guesses: [Guess] = []
    var remainingClueBoxes: [ClueBox] = []
    
    mutating func withGamePhase(gamePhase: GamePhase) -> GameStateBuilder {
        self.gamePhase = gamePhase
        return self
    }
    
    mutating func withNumMistakesRemaining(numMistakesRemaining: Int) -> GameStateBuilder {
        self.numMistakesRemaining = numMistakesRemaining
        return self
    }
    
    mutating func withCompletedCategories(completedCategories: [Category]) -> GameStateBuilder {
        self.completedCategories = completedCategories
        return self
    }
    
    mutating func withGuesses(guesses: [Guess]) -> GameStateBuilder {
        self.guesses = guesses
        return self
    }
    
    mutating func withRemainingClueBoxes(remainingClueBoxes: [ClueBox]) -> GameStateBuilder {
        self.remainingClueBoxes = remainingClueBoxes
        return self
    }
    
    func build() -> GameState {
        return GameState(gamePhase: self.gamePhase, numMistakesRemaining: self.numMistakesRemaining, completedCategories: self.completedCategories, guesses: self.guesses, remainingClueBoxes: self.remainingClueBoxes)
    }
}
