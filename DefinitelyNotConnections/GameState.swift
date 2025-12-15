//
//  GameState.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import Foundation

struct GameState {
    var gamePhase: GamePhase
    var numMistakesRemaining: Int
    var completedCategories: [Category]
    var guesses: [Guess]
    var lastGuessShakesBoxes: Bool = false
    var remainingClueBoxes: [ClueBox]

    
    init(clueBoxes: [ClueBox]) {
        self.gamePhase = .setup
        self.completedCategories = []
        self.guesses = []
        self.remainingClueBoxes = clueBoxes
        self.numMistakesRemaining = 4
    }
    
    init(gamePhase: GamePhase, numMistakesRemaining: Int, completedCategories: [Category], guesses: [Guess], remainingClueBoxes: [ClueBox]) {
        self.gamePhase = gamePhase
        self.completedCategories = completedCategories
        self.guesses = guesses
        self.remainingClueBoxes = remainingClueBoxes
        self.numMistakesRemaining = numMistakesRemaining
    }
}
