//
//  GameGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 28.12.25.
//

import Foundation

struct GameGrid {
    var remainingClueBoxes: RemainingClueBoxes
    var completedCategories: [Category]
    
    init(clueBoxes: [ClueBox]) {
        self.remainingClueBoxes = RemainingClueBoxes(clueBoxes: clueBoxes)
        self.completedCategories = []
    }
    
    init(remainingClueBoxes: RemainingClueBoxes, completedCategories: [Category]) {
        self.remainingClueBoxes = remainingClueBoxes
        self.completedCategories = completedCategories
    }
}
