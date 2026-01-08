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
    let gameGrid: GameGrid
    let allGuesses: AllGuesses
    let popup: Popup
    let mistakes: Mistakes
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.gamePhase = .setup
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.allGuesses = AllGuesses()
        self.popup = Popup()
        self.mistakes = Mistakes()
    }
    
    public func resetGame() {
        self.gamePhase = .setup
        self.gameGrid.reset()
        self.allGuesses.reset()
        self.mistakes.reset()
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
    
    private func shakeSelectedBoxes() {
        self.gameGrid.remainingClueBoxes.selectedClueBoxes.forEach { box in
            box.startShake()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.gameGrid.remainingClueBoxes.selectedClueBoxes.forEach { box in
                box.stopShake()
            }
        }
    }
    
    private func handleCorrectGuess(guess: Guess) {
        self.gameGrid.completeCategory(category: self.allCategories[guess.correctCategoryID!])
        self.gameGrid.remainingClueBoxes.removeSelectedClueBoxes()
        if self.gameGrid.sortedCompletedCategories.count == 4 {
            admirePuzzle()
        }
    }
    
    private func handleIncorrectGuess(guess: Guess) {
        shakeSelectedBoxes()
        self.mistakes.madeMistake()
        if guess.oneAway {
            self.popup.activateOneAway()
        }
    }
    
    private func handleAlreadyGuessed() {
        self.popup.activateAlreadyGuessed()
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
