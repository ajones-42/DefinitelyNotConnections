//
//  GameGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 28.12.25.
//

import Foundation

struct GameGrid {
    let allCategories: [Category]
    let remainingClueBoxes: RemainingClueBoxes

    var sortedCompletedCategories: [Category] {
        self.allCategories.filter( {$0.isCompleted} ).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    var numCompletedCategories: Int {
        self.sortedCompletedCategories.count
    }
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.remainingClueBoxes = RemainingClueBoxes(allClueBoxes: getAllClueBoxes(categories: self.allCategories), shuffled: true)
    }
    
    init(allCategories: [Category], remainingClueBoxes: RemainingClueBoxes) {
        self.allCategories = allCategories
        self.remainingClueBoxes = remainingClueBoxes
    }
    
    func reset() -> GameGrid {
        let resetCategories: [Category] = self.allCategories.replaced(where: {$0.isCompleted}, withResultOf: {$0.reset()})
        return GameGrid(allCategories: resetCategories, remainingClueBoxes: self.remainingClueBoxes.reset())
    }
    
    func completeCategory(category: Category) -> GameGrid {
        let newCategories: [Category] = self.allCategories.replaced(where: {$0.id == category.id}, withResultOf: {$0.complete(orderCompleted: getNextCompletedCategoryOrder())})
        let newRemainingClueBoxes: RemainingClueBoxes = self.remainingClueBoxes.removeSelectedClueBoxes()
        return GameGrid(allCategories: newCategories, remainingClueBoxes: newRemainingClueBoxes)
    }
    
    private func getNextCompletedCategoryOrder() -> Int {
        return self.sortedCompletedCategories.count
    }
    
    func clickClueBox(clueBox: ClueBox) -> GameGrid {
        return GameGrid(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.clickClueBox(clueBox: clueBox))
    }
    
    func shuffleClueBoxes() -> GameGrid {
        return GameGrid(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.shuffleClueBoxes())
    }
    
    func deselectAllClueBoxes() -> GameGrid {
        return GameGrid(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.deselectAllClueBoxes())
    }
    
    func startShakingSelectedBoxes() -> GameGrid {
        return GameGrid(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.startShakingSelectedBoxes())
    }
    
    func stopShakingSelectedBoxes() -> GameGrid {
        return GameGrid(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.stopShakingSelectedBoxes())
    }
}
