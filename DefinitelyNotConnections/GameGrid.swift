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
    
    func completeCategory(category: Category) {
        self.completedCategories.append(category)
    }
    
    func getCompletedCategories() -> [Category] {
        return self.completedCategories
    }
}
