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
        self.allCategories.filter( {$0.orderCompleted != nil} ).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    var numCompletedCategories: Int {
        self.sortedCompletedCategories.count
    }
    
    init(categories: [Category]) {
        self.allCategories = categories
        self.remainingClueBoxes = RemainingClueBoxes(clueBoxes: getAllClueBoxes(categories: self.allCategories), shuffled: true)
    }
    
    init(allCategories: [Category], remainingClueBoxes: RemainingClueBoxes) {
        self.allCategories = allCategories
        self.remainingClueBoxes = remainingClueBoxes
    }
    
    private func updateSingleCategory(categoryID: Int, newCategory: Category) -> [Category] {
        if let categoryIndex = self.allCategories.firstIndex(where: {$0.id == categoryID}) {
            var newCategories: [Category] = self.allCategories
            newCategories[categoryIndex] = newCategory
            return newCategories
        } else {
            return self.allCategories
        }
    }
    
    func reset() -> GameGrid {
        var resetCategories: [Category] = self.allCategories
        self.allCategories.forEach { category in
            resetCategories.append(Category(name: category.name, clueBoxes: category.clueBoxes, colour: category.colour, id: category.id, orderCompleted: nil))
        }
        return GameGrid(categories: resetCategories)
    }
    
    func completeCategory(category: Category) -> GameGrid {
        let newCategories: [Category] = updateSingleCategory(categoryID: category.id, newCategory: Category(name: category.name, clueBoxes: category.clueBoxes, colour: category.colour, id: category.id, orderCompleted: getNextCompletedCategoryOrder()))
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
    
    func startShakingSelectedBoxes() -> GameGrid {
        return GameGrid(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.startShakingSelectedBoxes())
    }
    
    func stopShakingSelectedBoxes() -> GameGrid {
        return GameGrid(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.stopShakingSelectedBoxes())
    }
    
    //func removeSelectedClueBoxes() -> GameGrid {
        //return GameGrid(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.removeSelectedClueBoxes())
    //}
    
    /*func reset() {
        self.allCategories.forEach { category in
            category.orderCompleted = nil
        }
        self.remainingClueBoxes = RemainingClueBoxes(clueBoxes: getAllClueBoxes(categories: self.allCategories))
    }
    
    func completeCategory(category: Category) {
        category.orderCompleted = getNextCompletedCategoryOrder()
    }
    
    func clickClueBox(clueBox: ClueBox) {
        self.remainingClueBoxes = self.remainingClueBoxes.clickClueBox(clueBox: clueBox)
    }
    
    func removeSelectedClueBoxes() {
        self.remainingClueBoxes = self.remainingClueBoxes.removeSelectedClueBoxes()
    }*/
}
