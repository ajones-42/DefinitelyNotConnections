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
    var gameGrid: GameGrid
    var guesses: [Guess]
    var numMistakesRemaining: Int
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.guesses = []
        self.numMistakesRemaining = 4
    }
    
    func resetGame() {
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.guesses = []
        self.numMistakesRemaining = 4
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
    
    func getGuesses() -> [Guess] {
        return self.guesses
    }
}
