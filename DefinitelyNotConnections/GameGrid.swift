//
//  GameGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 28.12.25.
//

import Foundation

@Observable
class GameGrid {
    let allCategories: [Category]
    var remainingClueBoxes: RemainingClueBoxes
    var completedCategories: [Category]
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.remainingClueBoxes = RemainingClueBoxes(clueBoxes: getAllClueBoxes(categories: self.allCategories))
        self.completedCategories = []
    }
    
    init(allCategories: [Category], remainingClueBoxes: RemainingClueBoxes, completedCategories: [Category]) {
        self.allCategories = allCategories
        self.remainingClueBoxes = remainingClueBoxes
        self.completedCategories = completedCategories
    }
    
    func getCompletedCategories() -> [Category] {
        return self.completedCategories
    }
    
    // Temporary
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.remainingClueBoxes.clueBoxes
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.remainingClueBoxes.getSelectedClueBoxes()
    }
    
    // Temporary
    func getNumSelectedClueBoxes() -> Int {
        return getSelectedClueBoxes().count
    }
    
    // Temporary
    func clickClueBox(clueBox: ClueBox) {
        if (getNumSelectedClueBoxes() < 4 || clueBox.isSelected) {
            clueBox.click()
        }
    }
}
