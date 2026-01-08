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
}
