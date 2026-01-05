//
//  GameState.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import Foundation

struct GameState {
    var gamePhase: GamePhase
    var guesses: [Guess]
    var lastGuessShakesBoxes: Bool = false

    
    init() {
        self.gamePhase = .setup
        self.guesses = []
    }
    
    init(gamePhase: GamePhase, guesses: [Guess]) {
        self.gamePhase = gamePhase
        self.guesses = guesses
    }
}
