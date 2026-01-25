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
    var gamePhase: GamePhase
    var categories: Categories
    var allGuesses: AllGuesses
    var popup: Popup?
    var mistakes: Mistakes
    
    init(setupInfo: SetupInfo) {
        self.gameProperties = GameProperties(numMistakes: 4, setupInfo: setupInfo)
        self.gamePhase = .setup
        self.categories = Categories(setupInfo: setupInfo)
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
    
    public func getOriginalNumMistakes() -> Int {
        return self.gameProperties.numMistakes
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
    
    public func getRemainingClueBoxes() -> [ClueBox] {
        return self.categories.getRemainingClueBoxes()
    }
    
    public func clickClueBox(clueBox: ClueBox) {
        self.categories = self.categories.clickClueBox(clueBox: clueBox)
    }
    
    public func shuffleClueBoxes() {
        self.categories = self.categories.shuffleClueBoxes()
    }
    
    public func getDeselectAllIsClickable() -> Bool {
        return self.categories.getDeselectAllIsClickable()
    }
    
    public func deselectAllClueBoxes() {
        self.categories = self.categories.deselectAllClueBoxes()
    }
    
    private func handleCorrectGuess(submitResult: SubmitResult) {
        self.categories = self.categories.completeCategory(categoryID: submitResult.categoryID)
        if self.categories.numCompletedCategories == self.gameProperties.numCategories {
            admirePuzzle()
        }
    }
    
    private func handleIncorrectGuess(guessOneAway: Bool) {
        shakeSelectedClueBoxesMomentarily(duration: 0.1)
        self.mistakes = self.mistakes.madeMistake()
        if guessOneAway {
            activatePopupMomentarily(message: "One Away!", duration: 2)
        }
    }
    
    private func handleAlreadyGuessed() {
        activatePopupMomentarily(message: "Already guessed!", duration: 2)
    }
    
    public func getSubmitIsClickable() -> Bool {
        return self.categories.getSubmitIsClickable()
    }

    private func addGuess(selectedClueInfos: [ClueInfo], bestMatch: SubmitResult) {
        let guess = Guess(clueInfos: selectedClueInfos, submitResult: bestMatch)
        self.allGuesses = self.allGuesses.addGuess(guess: guess)
    }
    
    private func getSubmitBestMatch(selectedClueInfos: [ClueInfo]) -> SubmitResult? {
        return self.categories.getSubmitBestMatch(selectedClueBoxIDs: selectedClueInfos.map({clueInfo in clueInfo.id}), numCluesPerCategory: self.gameProperties.numCluesPerCategory)
    }
    
    public func submitSelection() {
        if getSubmitIsClickable() {
            let selectedClueInfos: [ClueInfo] = self.categories.allClueBoxes.selectedClueBoxes.map({clueBox in
                clueBox.clueInfo})
            
            if self.allGuesses.selectionAlreadyGuessed(selectedClueBoxIDs: selectedClueInfos.map({clueInfo in clueInfo.id})) {
                handleAlreadyGuessed()
            } else {
                if let bestMatch: SubmitResult = getSubmitBestMatch(selectedClueInfos: selectedClueInfos) {
                    addGuess(selectedClueInfos: selectedClueInfos, bestMatch: bestMatch)
                    if bestMatch.isCorrect {
                        handleCorrectGuess(submitResult: bestMatch)
                    } else {
                        handleIncorrectGuess(guessOneAway: bestMatch.isOneAway)
                    }
                }
            }
        }
    }
}
