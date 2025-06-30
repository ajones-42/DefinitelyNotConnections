//
//  GameState.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import Foundation

@Observable
class GameState {
    private(set) var gamePhase: gamePhase
    
    init() {
        self.gamePhase = .setup
    }
    
    func startPlaying() {
        self.gamePhase = .playing
    }
    
    func finishedPlaying() {
        self.gamePhase = .finished
    }
}
