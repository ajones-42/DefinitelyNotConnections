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
    var mainGame: MainGame
    let allCategories: [Category]
    
    init() {
        self.allCategories = ConnectionsGameModel.getCategories()
        self.mainGame = MainGame(categories: self.allCategories)
    }
    
    init(mainGame: MainGame, categories: [Category]) {
        self.allCategories = categories
        self.mainGame = mainGame
    }
    
    func resetGame() {
        self.mainGame.resetGame()
    }
    
    static func getCategories() -> [Category] {
        return createDefaultTestCategories()
    }
    
    // GamePhase
    
    func getCurrentGamePhase() -> GamePhase {
        return self.mainGame.getCurrentGamePhase()
    }
    
    // ClueBoxes
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.mainGame.gameGrid.remainingClueBoxes.getSelectedClueBoxes()
    }
    
    func getNumSelectedClueBoxes() -> Int {
        return self.mainGame.gameGrid.remainingClueBoxes.getNumSelectedClueBoxes()
    }
    
    // Guesses
    
    func getLastGuessShakesBoxes() -> Bool {
        return self.mainGame.lastGuessShakesBoxes
    }
    
    // Categories
    
    func handleIncorrectGuess(guess: Guess) {
        self.mainGame.lastGuessShakesBoxes = true
        self.mainGame.madeMistake()
        if guess.oneAway {
            self.mainGame.popup.activateOneAway()
        }
    }
    
    func handleAlreadyGuessed() {
        self.mainGame.lastGuessShakesBoxes = true
        self.mainGame.popup.activateAlreadyGuessed()
    }


    
    func submitSelection() {
        let selectedBoxes: [ClueBox] = getSelectedClueBoxes()

        if self.mainGame.allGuesses.selectionAlreadyGuessed(selectedBoxIDs: getClueBoxIDs(clueBoxes: selectedBoxes)) {
            handleAlreadyGuessed()
        } else {
            let guess: Guess = Guess(allCategories: self.allCategories, selectedBoxes: selectedBoxes, id: self.mainGame.allGuesses.getNextGuessID())
            self.mainGame.allGuesses.addGuess(guess: guess)
            
            if guess.isCorrect() {
                self.mainGame.handleCorrectGuess(guess: guess)
            } else {
                handleIncorrectGuess(guess: guess)
            }
        }
    }
}
