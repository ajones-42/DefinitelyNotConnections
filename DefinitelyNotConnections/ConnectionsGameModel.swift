//
//  ConnectionsGameModel.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import Foundation
import SwiftUI

@Observable
class ConnectionsGameModel {
    private(set) var gameState: GameState
    var mainGame: MainGame
    let allCategories: [Category]
    
    var popupTrigger: Bool = false // Actual value doesn't matter, but must change to trigger OneAway/AlreadyGuessed.
    var popupText: String = ""
    let oneAwayText: String = "One away!"
    let alreadyGuessedText: String = "Already guessed!"
    
    init() {
        self.allCategories = ConnectionsGameModel.getCategories()
        self.gameState = GameState()
        self.mainGame = MainGame(categories: self.allCategories)
    }
    
    init(gameState: GameState, mainGame: MainGame, categories: [Category]) {
        self.gameState = gameState
        self.allCategories = categories
        self.mainGame = mainGame
    }
    
    func resetGame() {
        self.gameState = GameState()
        self.mainGame.resetGame()
    }
    
    static func getCategories() -> [Category] {
        return createDefaultTestCategories()
    }
    
    // GamePhase
    
    func startPlaying() {
        self.gameState.gamePhase = .playing
    }
    
    func finishPlaying() {
        self.gameState.gamePhase = .finished
    }
    
    func admirePuzzle() {
        self.gameState.gamePhase = .admiring
    }
    
    func getCurrentGamePhase() -> GamePhase {
        return self.gameState.gamePhase
    }
    
    // ClueBoxes
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.mainGame.gameGrid.remainingClueBoxes.getSelectedClueBoxes()
    }
    
    func getNumSelectedClueBoxes() -> Int {
        return self.mainGame.gameGrid.remainingClueBoxes.getNumSelectedClueBoxes()
    }
    
    func removeSelectedClueBoxes() {
        self.mainGame.gameGrid.remainingClueBoxes.removeSelectedClueBoxes()
    }
    
    // Guesses
    
    func getLastGuessShakesBoxes() -> Bool {
        return self.gameState.lastGuessShakesBoxes
    }
    
    // Categories
    
    func completeCategory(correctCategoryIndex: Int) {
        self.mainGame.gameGrid.completedCategories.append(self.allCategories[correctCategoryIndex])
    }
    
    
    func correctGuess(guess: Guess) {
        self.gameState.lastGuessShakesBoxes = false
        completeCategory(correctCategoryIndex: guess.correctCategoryID!)
        removeSelectedClueBoxes()
        if self.mainGame.gameGrid.completedCategories.count == 4 {
            admirePuzzle()
        }
    }
    
    func incorrectGuess(guess: Guess) {
        self.gameState.lastGuessShakesBoxes = true
        self.mainGame.madeMistake()
        if guess.oneAway {
            activatePopup(popupText: self.oneAwayText)
        }
    }
    
    func alreadyGuessed() {
        self.gameState.lastGuessShakesBoxes = true
        activatePopup(popupText: self.alreadyGuessedText)
    }


    
    func submitSelection() {
        let selectedBoxes: [ClueBox] = getSelectedClueBoxes()

        if self.mainGame.selectionAlreadyGuessed(selectedBoxIDs: getClueBoxIDs(clueBoxes: selectedBoxes)) {
            alreadyGuessed()
        } else {
            let guess: Guess = self.mainGame.computeGuess(selectedBoxes: selectedBoxes, guessID: self.mainGame.getNextGuessID())
            self.mainGame.addGuess(guess: guess)
            
            if guess.isCorrect() {
                correctGuess(guess: guess)
            } else {
                incorrectGuess(guess: guess)
            }
        }
    }
    
    func activatePopup(popupText: String) {
        self.popupText = popupText
        self.popupTrigger.toggle()
    }
    
    func activateSelectedBoxesShake() {
        getSelectedClueBoxes().forEach { box in
            box.activateShake()
        }
    }
    
    func deactivateSelectedBoxesShake() {
        getSelectedClueBoxes().forEach { box in
            box.deactivateShake()
        }
    }
}
