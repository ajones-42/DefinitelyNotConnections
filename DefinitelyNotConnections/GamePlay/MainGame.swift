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
    let gameGrid: GameGrid
    let allGuesses: AllGuesses
    let popup: Popup
    let mistakes: Mistakes
    
    init(setupInfo: SetupInfo) {
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.gamePhase = .setup
        self.gameGrid = GameGrid(setupInfo: setupInfo, gameProperties: self.gameProperties)
        self.allGuesses = AllGuesses()
        self.popup = Popup()
        self.mistakes = Mistakes(gameProperties: self.gameProperties)
    }
    
    init(gameProperties: GameProperties, gamePhase: GamePhase, gameGrid: GameGrid, allGuesses: AllGuesses, popup: Popup, mistakes: Mistakes) {
        self.gameProperties = gameProperties
        self.gamePhase = gamePhase
        self.gameGrid = gameGrid
        self.allGuesses = allGuesses
        self.popup = popup
        self.mistakes = mistakes
    }
    
    public func resetGame() {
        resetGamePhase()
        resetCategories()
        resetAllGuesses()
        resetMistakes()
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
    
    private func resetGamePhase() {
        self.gamePhase = .setup
    }
    
    private func resetCategories() {
        self.gameGrid.reset()
    }
    
    private func resetMistakes() {
        self.mistakes.reset()
    }
    
    private func resetAllGuesses() {
        self.allGuesses.reset()
    }
    
    private func activatePopupMomentarily(message: String, duration: TimeInterval) {
        self.popup.activateMomentarily(message: message, duration: duration)
    }
    
    private func deactivatePopup() {
        self.popup.deactivate()
    }
    
    private func shakeSelectedClueBoxesMomentarily(duration: TimeInterval) {
        self.gameGrid.startShakingSelectedClueBoxes()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.gameGrid.stopShakingSelectedClueBoxes()
        }
    }
    
    private func handleCorrectGuess(submitResult: SubmitResult) {
        self.gameGrid.completeCategory(categoryID: submitResult.categoryID)
        if self.gameGrid.getNumCompletedCategories() == self.gameProperties.numCategories {
            admirePuzzle()
        }
    }
    
    private func handleIncorrectGuess(guessOneAway: Bool) {
        shakeSelectedClueBoxesMomentarily(duration: 0.1)
        self.mistakes.madeMistake()
        if guessOneAway {
            activatePopupMomentarily(message: "One Away!", duration: 2)
        }
    }
    
    private func handleAlreadyGuessed() {
        activatePopupMomentarily(message: "Already guessed!", duration: 2)
    }
    
    public func getSubmitIsClickable() -> Bool {
        return self.gameGrid.getSubmitIsClickable()
    }
    
    private func getSelectionAlreadyGuessed(selectedClueBoxIDs: [UUID], guesses: [Guess]) -> Bool {
        return guesses.map({guess in
                guess.clueBoxesMatchGuess(clueBoxIDs: selectedClueBoxIDs)
            }).contains(true)
    }

    private func addGuess(selectedClueInfos: [ClueInfo], bestMatch: SubmitResult) {
        let guess = Guess(clueInfos: selectedClueInfos, submitResult: bestMatch)
        self.allGuesses.addGuess(guess: guess)
    }
    
    private func getSubmitBestMatch(selectedClueBoxCategoryIDs: [UUID]) -> SubmitResult? {
        let counts = selectedClueBoxCategoryIDs.reduce(into: [:]) { counts, categoryID in counts[categoryID, default: 0] += 1 }
        if let bestCategory = counts.max(by: {a, b in a.value < b.value}) {
            return SubmitResult(categoryID: bestCategory.key, numMatches: bestCategory.value, numCluesPerCategory: self.gameProperties.numCluesPerCategory)
        } else {
            return nil
        }
    }
    
    public func submitSelection() {
        if getSubmitIsClickable() {
            deactivatePopup()
            let selectedClueInfos: [ClueInfo] = self.gameGrid.getSelectedClueBoxes().map({clueBox in
                clueBox.clueInfo})
            let selectedClueBoxIDs = selectedClueInfos.map({clueInfo in
                clueInfo.id
            })
            let selectedClueBoxCategoryIDs: [UUID] = selectedClueInfos.map({clueInfo in
                clueInfo.categoryID
            })
            let allCategories = self.gameGrid.getCategories()
            let guesses = self.allGuesses.guesses
            
            if getSelectionAlreadyGuessed(selectedClueBoxIDs: selectedClueBoxIDs, guesses: guesses) {
                handleAlreadyGuessed()
            } else {
                if let bestMatch: SubmitResult = getSubmitBestMatch(selectedClueBoxCategoryIDs: selectedClueBoxCategoryIDs) {
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
