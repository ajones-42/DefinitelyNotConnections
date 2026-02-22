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
            print("MainGame.handleCorrectGuess: Unable to complete connections category with ID \(submitBestMatch.connectionsCategoryID)")
        }
    }
    
    private func handleIncorrectGuess(guessOneAway: Bool) {
        shakeSelectedRemainingClueBoxesMomentarily(duration: 0.1)
        do {
            try self.mistakes.madeMistake()
        } catch {
            print("MainGame.handleIncorrectGuess: Could not decrement mistakes. Setting to 0 remaining mistakes.")
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
    
    private func getNumMatchesPerConnectionsCategory(selectedClueBoxConnectionsCategoryIDs: [UUID]) -> Dictionary<UUID, Int> {
        return selectedClueBoxConnectionsCategoryIDs.reduce(into: [:]) { counts, connectionsCategoryID in counts[connectionsCategoryID, default: 0] += 1 }
    }
    
    private func getBestMatchConnectionsCategory(selectedClueBoxConnectionsCategoryIDs: [UUID]) throws -> Dictionary<UUID, Int>.Element {
        let numMatchesPerConnectionsCategory: Dictionary<UUID, Int> = getNumMatchesPerConnectionsCategory(selectedClueBoxConnectionsCategoryIDs: selectedClueBoxConnectionsCategoryIDs)
        if let bestMatchConnectionsCategory: Dictionary<UUID, Int>.Element = numMatchesPerConnectionsCategory.max(by: {a, b in a.value < b.value}) {
            return bestMatchConnectionsCategory
        } else {
            print("MainGame.getBestMatchConnectionsCategory: Could not find best matching Connections category.")
            throw ValidationError.submissionError
        }
    }
    
    private func getSubmitBestMatch(selectedClueBoxConnectionsCategoryIDs: [UUID]) throws -> SubmitBestMatch {
        do {
            let bestMatchConnectionsCategory: Dictionary<UUID, Int>.Element = try getBestMatchConnectionsCategory(selectedClueBoxConnectionsCategoryIDs: selectedClueBoxConnectionsCategoryIDs)
            return SubmitBestMatch(connectionsCategoryID: bestMatchConnectionsCategory.key, numMatches: bestMatchConnectionsCategory.value, numCluesPerConnectionsCategory: self.gameProperties.numCluesPerConnectionsCategory)
        } catch {
            throw error
        }
    }
    
    public func submitSelection() {
        if getSubmitIsClickable() {
            deactivatePopup()
            let selectedRemainingClueBoxes: [ClueBox] = self.gameGrid.getSelectedRemainingClueBoxes()

            do {
                let submitBestMatch: SubmitBestMatch = try getSubmitBestMatch(selectedClueBoxConnectionsCategoryIDs: selectedRemainingClueBoxes.map({$0.getConnectionsCategoryID()}))
                let guess = Guess(clueInfos: selectedRemainingClueBoxes.map({$0.clueInfo}), submitBestMatch: submitBestMatch)
                try self.allGuesses.addGuess(guess: guess)
                if submitBestMatch.isCorrect {
                    handleCorrectGuess(submitBestMatch: submitBestMatch)
                } else {
                    handleIncorrectGuess(guessOneAway: submitBestMatch.isOneAway)
                }
            } catch ValidationError.alreadyGuessed {
                handleAlreadyGuessed()
            } catch {
                print("MainGame.submitSelection: Could not handle submit.")
            }
        }
    }
}
