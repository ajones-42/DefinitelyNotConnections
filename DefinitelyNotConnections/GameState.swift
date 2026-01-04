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
    var guesses: [Guess]
    var lastGuessShakesBoxes: Bool = false

    
    init() {
        self.gamePhase = .setup
        self.guesses = []
        self.numMistakesRemaining = 4
    }
    
    init(gamePhase: GamePhase, numMistakesRemaining: Int, guesses: [Guess]) {
        self.gamePhase = gamePhase
        self.guesses = guesses
        self.numMistakesRemaining = numMistakesRemaining
    }
}
