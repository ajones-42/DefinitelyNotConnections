//
//  GameState.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import Foundation

struct GameState {
    var gamePhase: GamePhase
    var lastGuessShakesBoxes: Bool = false

    
    init() {
        self.gamePhase = .setup
    }
    
    init(gamePhase: GamePhase) {
        self.gamePhase = gamePhase
    }
}
