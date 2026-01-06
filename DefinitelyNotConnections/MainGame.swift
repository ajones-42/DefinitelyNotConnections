//
//  Game.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import Foundation

@Observable
class MainGame {
    let allCategories: [Category]
    var gamePhase: GamePhase
    var gameGrid: GameGrid
    var allGuesses: AllGuesses
    var numMistakesRemaining: Int
    var lastGuessShakesBoxes: Bool = false
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.gamePhase = .setup
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.allGuesses = AllGuesses()
        self.numMistakesRemaining = 4
    }
    
    func resetGame() {
        self.gamePhase = .setup
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.allGuesses = AllGuesses()
        self.numMistakesRemaining = 4
    }
    
    // GamePhase
    
    func startPlaying() {
        self.gamePhase = .playing
    }
    
    func finishPlaying() {
        self.gamePhase = .finished
    }
    
    func admirePuzzle() {
        self.gamePhase = .admiring
    }
    
    func getCurrentGamePhase() -> GamePhase {
        return self.gamePhase
    }
    
    func getNumMistakesRemaining() -> Int {
        return self.numMistakesRemaining
    }
    
    func madeMistake() {
        self.numMistakesRemaining -= 1
    }
    
    func resetNumMistakesRemaining() {
        self.numMistakesRemaining = 4
    }
}
