//
//  Game.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import Foundation

@Observable
class MainGame {
    let gameProperties: GameProperties
    let allCategories: [Category]
    var gamePhase: GamePhase
    let gameGrid: GameGrid
    let allGuesses: AllGuesses
    var popup: Popup?
    var mistakes: Mistakes
    
    init(gameProperties: GameProperties, categories: [Category]) {
        self.gameProperties = gameProperties
        self.allCategories = categories
        self.gamePhase = .setup
        self.gameGrid = GameGrid(categories: categories)
        self.allGuesses = AllGuesses()
        self.popup = nil
        self.mistakes = Mistakes(numMistakesRemaining: gameProperties.numMistakes)
    }
    
    public func resetGame() {
        self.gamePhase = .setup
        self.gameGrid.reset()
        self.allGuesses.reset()
        resetMistakesRemaining()
    }
    
    // GamePhase
    
    public func startPlaying() {
        self.gamePhase = .playing
    }
    
    public func finishPlaying() {
        self.gamePhase = .finished
    }
    
    public func admirePuzzle() {
        self.gamePhase = .admiring
    }
    
    public func getOutOfMistakes() -> Bool {
        return self.mistakes.outOfMistakes
    }
    
    public func resetMistakesRemaining() {
        self.mistakes = Mistakes(numMistakesRemaining: gameProperties.numMistakes)
    }
    
    private func activatePopupMomentarily(message: String, duration: TimeInterval) {
        self.popup = Popup(message: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.popup = nil
        }
    }
    
    private func handleCorrectGuess(guess: Guess) {
        self.gameGrid.completeCategory(category: self.allCategories[guess.correctCategoryID!])
        self.gameGrid.remainingClueBoxes.removeSelectedClueBoxes()
        if self.gameGrid.numCompletedCategories == 4 {
            admirePuzzle()
        }
    }
    
    private func handleIncorrectGuess(guess: Guess) {
        self.gameGrid.remainingClueBoxes.shakeSelectedBoxes()
        self.mistakes = self.mistakes.madeMistake()
        if guess.oneAway {
            activatePopupMomentarily(message: "One Away!", duration: 2)
        }
    }
    
    private func handleAlreadyGuessed() {
        activatePopupMomentarily(message: "Already guessed!", duration: 2)
    }
    
    public func submitIsClickable() -> Bool {
        return gameGrid.remainingClueBoxes.submitIsClickable
    }
    
    public func submitSelection() {
        if submitIsClickable() {
            let selectedBoxes: [ClueBox] = self.gameGrid.remainingClueBoxes.selectedClueBoxes
            
            if self.allGuesses.selectionAlreadyGuessed(selectedBoxIDs: getClueBoxIDs(clueBoxes: selectedBoxes)) {
                handleAlreadyGuessed()
            } else {
                let guess: Guess = Guess(allCategories: self.allCategories, selectedBoxes: selectedBoxes, id: self.allGuesses.getNextGuessID())
                self.allGuesses.addGuess(guess: guess)
                
                if guess.isCorrect() {
                    handleCorrectGuess(guess: guess)
                } else {
                    handleIncorrectGuess(guess: guess)
                }
            }
        }
    }
}
