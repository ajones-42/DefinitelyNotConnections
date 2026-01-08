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
    var completedCategories: [Category] {
        self.allCategories.filter( {$0.orderCompleted != nil} ).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.remainingClueBoxes = RemainingClueBoxes(clueBoxes: getAllClueBoxes(categories: self.allCategories))
    }
    
    init(allCategories: [Category], remainingClueBoxes: RemainingClueBoxes, completedCategories: [Category]) {
        self.allCategories = allCategories
        self.remainingClueBoxes = remainingClueBoxes
    }
    
    func getNextCompletedCategoryOrder() -> Int {
        return self.completedCategories.count
    }
    
    func completeCategory(category: Category) {
        category.orderCompleted = getNextCompletedCategoryOrder()
    }
    
    func getCompletedCategories() -> [Category] {
        return self.completedCategories
    }
}
