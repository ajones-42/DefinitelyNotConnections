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
    var popup: Popup
    var numMistakesRemaining: Int
    var noMistakesLeft: Bool {
        self.numMistakesRemaining == 0
    }
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.gamePhase = .setup
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.allGuesses = AllGuesses()
        self.popup = Popup()
        self.numMistakesRemaining = 4
    }
    
    func resetGame() {
        self.gamePhase = .setup
        self.gameGrid.reset()
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
    
    func shakeSelectedBoxes() {
        self.gameGrid.remainingClueBoxes.selectedClueBoxes.forEach { box in
            box.startShake()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.gameGrid.remainingClueBoxes.selectedClueBoxes.forEach { box in
                box.stopShake()
            }
        }
    }
    
    func handleCorrectGuess(guess: Guess) {
        self.gameGrid.completeCategory(category: self.allCategories[guess.correctCategoryID!])
        self.gameGrid.remainingClueBoxes.removeSelectedClueBoxes()
        if self.gameGrid.sortedCompletedCategories.count == 4 {
            admirePuzzle()
        }
    }
    
    func handleIncorrectGuess(guess: Guess) {
        shakeSelectedBoxes()
        madeMistake()
        if guess.oneAway {
            self.popup.activateOneAway()
        }
    }
    
    func handleAlreadyGuessed() {
        self.popup.activateAlreadyGuessed()
    }
    
    func submitIsClickable() -> Bool {
        return gameGrid.remainingClueBoxes.submitIsClickable
    }
    
    func submitSelection() {
        if submitIsClickable() {
            let selectedBoxes: [ClueBox] = self.gameGrid.remainingClueBoxes.selectedClueBoxes
            
            if self.allGuesses.selectionAlreadyGuessed(selectedBoxIDs: getClueBoxIDs(clueBoxes: selectedBoxes)) {
                self.handleAlreadyGuessed()
            } else {
                let guess: Guess = Guess(allCategories: self.allCategories, selectedBoxes: selectedBoxes, id: self.allGuesses.getNextGuessID())
                self.allGuesses.addGuess(guess: guess)
                
                if guess.isCorrect() {
                    self.handleCorrectGuess(guess: guess)
                } else {
                    self.handleIncorrectGuess(guess: guess)
                }
            }
        }
    }
}
