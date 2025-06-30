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
    private(set) var completedCategories: [Category] {
        didSet {
            if completedCategories.count == 4 {
                finishedPlaying()
            }
        }
    }
    
    init() {
        self.gamePhase = .setup
        self.completedCategories = []
    }
    
    func startPlaying() {
        self.gamePhase = .playing
    }
    
    func finishedPlaying() {
        self.gamePhase = .finished
    }
    
    func completeCategory(category: Category) {
        self.completedCategories.append(category)
    }
}
