//
//  GameGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 28.12.25.
//

import Foundation

struct GameGrid {
    let categories: Categories
    
    init(categories: [Category]) {
        let remainingClueBoxes: RemainingClueBoxes = RemainingClueBoxes(allClueBoxes: getAllClueBoxes(categories: categories), shuffled: true)
        self.categories = Categories(allCategories: categories, remainingClueBoxes: remainingClueBoxes)
    }
    
    init(categories: Categories) {
        self.categories = categories
    }
    
    func reset() -> GameGrid {
        return GameGrid(categories: self.categories.reset())
    }
    
    func completeCategory(category: Category) -> GameGrid {
        let newCategories: Categories = self.categories.completeCategory(category: category)
        return GameGrid(categories: newCategories)
    }
    
    func clickClueBox(clueBox: ClueBox) -> GameGrid {
        return GameGrid(categories: self.categories.clickClueBox(clueBox: clueBox))
    }
    
    func shuffleClueBoxes() -> GameGrid {
        return GameGrid(categories: self.categories.shuffleClueBoxes())
    }
    
    func deselectAllClueBoxes() -> GameGrid {
        return GameGrid(categories: self.categories.deselectAllClueBoxes())
    }
    
    func startShakingSelectedClueBoxes() -> GameGrid {
        return GameGrid(categories: self.categories.startShakingSelectedClueBoxes())
    }
    
    func stopShakingSelectedClueBoxes() -> GameGrid {
        return GameGrid(categories: self.categories.stopShakingSelectedClueBoxes())
    }
}
