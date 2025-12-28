//
//  GameGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 28.12.25.
//

import Foundation

class GameGrid {
    var remainingClueBoxes: RemainingClueBoxes
    var completedCategories: [Category]
    
    init(remainingClueBoxes: RemainingClueBoxes) {
        self.remainingClueBoxes = remainingClueBoxes
        self.completedCategories = []
    }
    
    init(remainingClueBoxes: RemainingClueBoxes, completedCategories: [Category]) {
        self.remainingClueBoxes = remainingClueBoxes
        self.completedCategories = completedCategories
    }
}
