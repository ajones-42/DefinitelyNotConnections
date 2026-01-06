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
    var guesses: [Guess]
    var numMistakesRemaining: Int
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.gamePhase = .setup
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.guesses = []
        self.numMistakesRemaining = 4
    }
    
    func resetGame() {
        self.gamePhase = .setup
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.guesses = []
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
    
    func addGuess(guess: Guess) {
        self.guesses.append(guess)
    }
    
    func getGuesses() -> [Guess] {
        return self.guesses
    }
    
    func getNextGuessID() -> Int {
        return self.guesses.count
    }
    
    func selectionAlreadyGuessed(selectedBoxIDs: [Int]) -> Bool {
        var selectionAlreadyGuessed: Bool = false
        for guess in self.getGuesses() {
            if getClueBoxIDs(clueBoxes: guess.clueBoxes).sorted() == selectedBoxIDs.sorted() {
                selectionAlreadyGuessed = true
                break
            }
        }
        return selectionAlreadyGuessed
    }
}
