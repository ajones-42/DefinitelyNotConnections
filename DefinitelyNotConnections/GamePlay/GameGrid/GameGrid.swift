//
//  GameGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 28.12.25.
//

import Foundation

struct GameGrid {
    let categories: Categories
    let remainingClueBoxes: RemainingClueBoxes
    
    init(categories: [Category]) {
        self.categories = Categories(allCategories: categories)
        self.remainingClueBoxes = RemainingClueBoxes(allClueBoxes: getAllClueBoxes(categories: categories), shuffled: true)
    }
    
    init(categories: Categories, remainingClueBoxes: RemainingClueBoxes) {
        self.categories = categories
        self.remainingClueBoxes = remainingClueBoxes
    }
    
    func reset() -> GameGrid {
        return GameGrid(categories: self.categories.reset(), remainingClueBoxes: self.remainingClueBoxes.reset())
    }
    
    func completeCategory(category: Category) -> GameGrid {
        let newCategories: Categories = self.categories.completeCategory(category: category)
        let newRemainingClueBoxes: RemainingClueBoxes = self.remainingClueBoxes.removeSelectedClueBoxes()
        return GameGrid(categories: newCategories, remainingClueBoxes: newRemainingClueBoxes)
    }
    
    func clickClueBox(clueBox: ClueBox) -> GameGrid {
        return GameGrid(categories: self.categories, remainingClueBoxes: self.remainingClueBoxes.clickClueBox(clueBox: clueBox))
    }
    
    func shuffleClueBoxes() -> GameGrid {
        return GameGrid(categories: self.categories, remainingClueBoxes: self.remainingClueBoxes.shuffleClueBoxes())
    }
    
    func deselectAllClueBoxes() -> GameGrid {
        return GameGrid(categories: self.categories, remainingClueBoxes: self.remainingClueBoxes.deselectAllClueBoxes())
    }
    
    func startShakingSelectedBoxes() -> GameGrid {
        return GameGrid(categories: self.categories, remainingClueBoxes: self.remainingClueBoxes.startShakingSelectedBoxes())
    }
    
    func stopShakingSelectedBoxes() -> GameGrid {
        return GameGrid(categories: self.categories, remainingClueBoxes: self.remainingClueBoxes.stopShakingSelectedBoxes())
    }
}
