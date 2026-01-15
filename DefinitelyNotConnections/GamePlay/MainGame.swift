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
    //let allCategories: [Category]
    var gamePhase: GamePhase
    var categories: Categories
    var allGuesses: AllGuesses
    var popup: Popup?
    var mistakes: Mistakes
    
    /*init(gameProperties: GameProperties, categories: [Category]) {
        self.gameProperties = gameProperties
        self.allCategories = categories
        self.gamePhase = .setup
        self.categories = Categories(allCategories: categories)
        self.allGuesses = AllGuesses(guesses: [])
        self.popup = nil
        self.mistakes = Mistakes(numMistakesRemaining: gameProperties.numMistakes)
    }*/
    
    init(gameProperties: GameProperties, categoryInfos: [CategoryInfo]) {
        self.gameProperties = gameProperties
        //self.allCategories = categories
        self.gamePhase = .setup
        //self.categories = Categories(allCategories: categories)
        self.categories = Categories(categoryInfos: categoryInfos)
        self.allGuesses = AllGuesses(guesses: [])
        self.popup = nil
        self.mistakes = Mistakes(numMistakesRemaining: gameProperties.numMistakes)
    }
    
    public func resetGame() {
        self.gamePhase = .setup
        self.categories = self.categories.reset()
        self.allGuesses = self.allGuesses.reset()
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
    
    private func shakeSelectedClueBoxesMomentarily(duration: TimeInterval) {
        self.categories = self.categories.startShakingSelectedClueBoxes()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.categories = self.categories.stopShakingSelectedClueBoxes()
        }
    }
    
    public func clickClueBox(clueBox: ClueBox) {
        self.categories = self.categories.clickClueBox(clueBox: clueBox)
    }
    
    public func shuffleClueBoxes() {
        self.categories = self.categories.shuffleClueBoxes()
    }
    
    public func deselectAllClueBoxes() {
        self.categories = self.categories.deselectAllClueBoxes()
    }
    
    private func completeCategory(category: Category) {
        self.categories = self.categories.completeCategory(category: category)
    }
    
    private func handleCorrectGuess(guess: Guess) {
        self.categories = self.categories.completeCategory(category: self.categories.allCategories[guess.correctCategoryID!])
        if self.categories.numCompletedCategories == 4 {
            admirePuzzle()
        }
    }
    
    private func handleIncorrectGuess(guess: Guess) {
        shakeSelectedClueBoxesMomentarily(duration: 0.1)
        self.mistakes = self.mistakes.madeMistake()
        if guess.oneAway {
            activatePopupMomentarily(message: "One Away!", duration: 2)
        }
    }
    
    private func handleAlreadyGuessed() {
        activatePopupMomentarily(message: "Already guessed!", duration: 2)
    }
    
    public func deselectAllIsClickable() -> Bool {
        return self.categories.remainingClueBoxes.deselectAllIsClickable
    }
    
    public func submitIsClickable() -> Bool {
        return self.categories.remainingClueBoxes.submitIsClickable
    }
    
    public func submitSelection() {
        if submitIsClickable() {
            let selectedBoxClues: [String] = self.categories.remainingClueBoxes.selectedClueBoxes.map({$0.text})
            
            //if self.allGuesses.selectionAlreadyGuessed(selectedBoxIDs: getClueBoxIDs(clueBoxes: selectedBoxes)) {
            if self.allGuesses.selectionAlreadyGuessed(selectedBoxClues: selectedBoxClues) {
                handleAlreadyGuessed()
            } else {
                let guess: Guess = Guess(allCategories: self.categories.allCategories, selectedClues: selectedBoxClues, id: self.allGuesses.getNextGuessID())
                self.allGuesses = self.allGuesses.addGuess(guess: guess)
                
                if guess.isCorrect() {
                    handleCorrectGuess(guess: guess)
                } else {
                    handleIncorrectGuess(guess: guess)
                }
            }
        }
    }
}
