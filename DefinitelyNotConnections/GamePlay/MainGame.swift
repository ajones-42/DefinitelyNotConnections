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
        resetConnectionsCategories()
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
    
    private func resetConnectionsCategories() {
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
    
    private func shakeSelectedRemainingClueBoxesMomentarily(duration: TimeInterval) {
        self.gameGrid.shakeSelectedRemainingClueBoxesMomentarily(duration: duration)
    }
    
    private func handleCorrectGuess(submitBestMatch: SubmitBestMatch) {
        do {
            try self.gameGrid.completeConnectionsCategory(connectionsCategoryID: submitBestMatch.connectionsCategoryID)
            if self.gameGrid.getNumCompletedConnectionsCategories() == self.gameProperties.numConnectionsCategories {
                admirePuzzle()
            }
        } catch {
            print("MainGame.handleCorrectGuess: Unable to complete connections category")
        }
    }
    
    private func handleIncorrectGuess(guessOneAway: Bool) {
        shakeSelectedRemainingClueBoxesMomentarily(duration: 0.1)
        do {
            try self.mistakes.madeMistake()
        } catch {
            print("MainGame.handleIncorrectGuess: Could not subtract from mistakes. Setting to 0 remaining mistakrs.")
            self.mistakes.setToZeroMistakesRemaining()
        }
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
    
    private func getSelectionAlreadyGuessed(selectedRemainingClueBoxes: [ClueBox], guesses: [Guess]) -> Bool {
        let selectedClueBoxIDs: [UUID] = selectedRemainingClueBoxes.map({clueBox in
            clueBox.getID()
        })
        return guesses.map({guess in
                guess.clueBoxesMatchGuess(clueBoxIDs: selectedClueBoxIDs)
            }).contains(true)
    }

    private func addGuess(selectedRemainingClueBoxes: [ClueBox], submitBestMatch: SubmitBestMatch) {
        let selectedClueInfos: [ClueInfo] = selectedRemainingClueBoxes.map({clueBox in
            clueBox.clueInfo
        })
        let guess = Guess(clueInfos: selectedClueInfos, submitBestMatch: submitBestMatch)
        self.allGuesses.addGuess(guess: guess)
    }
    
    private func getSubmitBestMatch(selectedRemainingClueBoxes: [ClueBox]) -> SubmitBestMatch? {
        let selectedClueBoxConnectionsCategoryIDs: [UUID] = selectedRemainingClueBoxes.map({clueBox in
            clueBox.getConnectionsCategoryID()
        })
        let counts: Dictionary<UUID, Int> = selectedClueBoxConnectionsCategoryIDs.reduce(into: [:]) { counts, connectionsCategoryID in counts[connectionsCategoryID, default: 0] += 1 }
        if let bestConnectionsCategory: Dictionary<UUID, Int>.Element = counts.max(by: {a, b in a.value < b.value}) {
            return SubmitBestMatch(connectionsCategoryID: bestConnectionsCategory.key, numMatches: bestConnectionsCategory.value, numCluesPerConnectionsCategory: self.gameProperties.numCluesPerConnectionsCategory)
        } else {
            return nil
        }
    }
    
    public func submitSelection() {
        if getSubmitIsClickable() {
            deactivatePopup()
            let selectedRemainingClueBoxes: [ClueBox] = self.gameGrid.getSelectedRemainingClueBoxes()
            let guesses = self.allGuesses.guesses
            
            if getSelectionAlreadyGuessed(selectedRemainingClueBoxes: selectedRemainingClueBoxes, guesses: guesses) {
                handleAlreadyGuessed()
            } else {
                if let submitBestMatch: SubmitBestMatch = getSubmitBestMatch(selectedRemainingClueBoxes: selectedRemainingClueBoxes) {
                    addGuess(selectedRemainingClueBoxes: selectedRemainingClueBoxes, submitBestMatch: submitBestMatch)
                    if submitBestMatch.isCorrect {
                        handleCorrectGuess(submitBestMatch: submitBestMatch)
                    } else {
                        handleIncorrectGuess(guessOneAway: submitBestMatch.isOneAway)
                    }
                }
            }
        }
    }
}
