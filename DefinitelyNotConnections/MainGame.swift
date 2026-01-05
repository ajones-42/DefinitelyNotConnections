//
//  Game.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import Foundation

struct MainGame {
    let allCategories: [Category]
    var gameGrid: GameGrid
    var numMistakesRemaining: Int
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.gameGrid = GameGrid(categories: self.allCategories)
        self.numMistakesRemaining = 4
    }
}
