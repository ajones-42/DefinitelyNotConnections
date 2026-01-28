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
    let categories: Categories
    let allGuesses: AllGuesses
    let popup: Popup
    let mistakes: Mistakes
    
    init(setupInfo: SetupInfo) {
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.gamePhase = .setup
        self.categories = Categories(setupInfo: setupInfo, gameProperties: self.gameProperties)
        self.allGuesses = AllGuesses()
        self.popup = Popup()
        self.mistakes = Mistakes(gameProperties: self.gameProperties)
    }
    
    init(gameProperties: GameProperties, gamePhase: GamePhase, categories: Categories, allGuesses: AllGuesses, popup: Popup, mistakes: Mistakes) {
        self.gameProperties = gameProperties
        self.gamePhase = gamePhase
        self.categories = categories
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
        self.categories.reset()
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
        self.categories.startShakingSelectedClueBoxes()
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.categories.stopShakingSelectedClueBoxes()
        }
    }
    
    public func shuffleClueBoxes() {
        self.categories.shuffleClueBoxes()
    }
    
    public func getDeselectAllIsClickable() -> Bool {
        return self.categories.getDeselectAllIsClickable()
    }
    
    public func deselectAllClueBoxes() {
        self.categories.deselectAllClueBoxes()
    }
    
    private func handleCorrectGuess(submitResult: SubmitResult) {
        self.categories.completeCategory(categoryID: submitResult.categoryID)
        if self.categories.numCompletedCategories == self.gameProperties.numCategories {
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
        return self.categories.getSubmitIsClickable()
    }

    private func addGuess(selectedClueInfos: [ClueInfo], bestMatch: SubmitResult) {
        let guess = Guess(clueInfos: selectedClueInfos, submitResult: bestMatch)
        self.allGuesses.addGuess(guess: guess)
    }
    
    private func getSubmitBestMatch(selectedClueInfos: [ClueInfo]) -> SubmitResult? {
        return self.categories.getSubmitBestMatch(selectedClueBoxIDs: selectedClueInfos.map({clueInfo in clueInfo.id}))
    }
    
    public func submitSelection() {
        if getSubmitIsClickable() {
            deactivatePopup()
            let selectedClueInfos: [ClueInfo] = self.categories.getSelectedClueBoxes().map({clueBox in
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
