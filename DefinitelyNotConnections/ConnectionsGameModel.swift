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
    
    func getNumSelectedClueBoxes() -> Int {
        return self.mainGame.gameGrid.remainingClueBoxes.getNumSelectedClueBoxes()
    }
    
    // Guesses
    
    func getLastGuessShakesBoxes() -> Bool {
        return self.mainGame.lastGuessShakesBoxes
    }
    
    // Categories
}
