//
//  Categories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation


struct Categories {
    let allCategories: [Category]
    let remainingClueBoxes: RemainingClueBoxes

    var sortedCompletedCategories: [Category] {
        self.allCategories.filter( {$0.isCompleted} ).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    var numCompletedCategories: Int {
        self.sortedCompletedCategories.count
    }
    
    init(allCategories: [Category], remainingClueBoxes: RemainingClueBoxes) {
        self.allCategories = allCategories
        self.remainingClueBoxes = remainingClueBoxes
    }
    
    /*init(allCategories: [Category]) {
        self.allCategories = allCategories
        self.remainingClueBoxes = RemainingClueBoxes(allClueBoxes: getAllClueBoxes(categories: self.allCategories), shuffled: true)
    }*/
    
    init(categoryInfos: [CategoryInfo]) {
        var categories: [Category] = []
        for (index, categoryInfo) in categoryInfos.enumerated() {
            categories.append(Category(id: index, categoryInfo: categoryInfo))
        }
        self.allCategories = categories
        self.remainingClueBoxes = RemainingClueBoxes(categoryInfos: categoryInfos, shuffled: true)
    }
    
    func reset() -> Categories {
        let resetCategories: [Category] = self.allCategories.replaced(where: {$0.isCompleted}, withResultOf: {$0.reset()})
        return Categories(allCategories: resetCategories, remainingClueBoxes: self.remainingClueBoxes.reset())
    }
    
    private func getNextCompletedCategoryOrder() -> Int {
        return self.sortedCompletedCategories.count
    }
    
    func completeCategory(category: Category) -> Categories {
        let newCategories: [Category] = self.allCategories.replaced(where: {$0.id == category.id}, withResultOf: {$0.complete(orderCompleted: getNextCompletedCategoryOrder())})
        return Categories(allCategories: newCategories, remainingClueBoxes: self.remainingClueBoxes.removeSelectedClueBoxes())
    }
    
    func clickClueBox(clueBox: ClueBox) -> Categories {
        return Categories(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.clickClueBox(clueBox: clueBox))
    }
    
    func shuffleClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.shuffleClueBoxes())
    }
    
    func deselectAllClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.deselectAllClueBoxes())
    }
    
    func startShakingSelectedClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.startShakingSelectedClueBoxes())
    }
    
    func stopShakingSelectedClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, remainingClueBoxes: self.remainingClueBoxes.stopShakingSelectedClueBoxes())
    }
}
