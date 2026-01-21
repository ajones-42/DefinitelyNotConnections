//
//  Categories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation


struct Categories {
    let allCategories: [Category]
    let allClueBoxes: AllClueBoxes

    var sortedCompletedCategories: [Category] {
        self.allCategories.filter( {$0.isCompleted} ).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    var numCompletedCategories: Int {
        self.sortedCompletedCategories.count
    }
    
    init(setupInfo: SetupInfo) {
        self.allCategories = setupInfo.categoryInfos.enumerated().map{ (index, categoryInfo) in
            Category(id: index, categoryInfo: categoryInfo)
        }
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, shuffled: true)
    }
    
    init(allCategories: [Category], allClueBoxes: AllClueBoxes) {
        self.allCategories = allCategories
        self.allClueBoxes = allClueBoxes
    }
    
    func reset() -> Categories {
        let resetCategories: [Category] = self.allCategories.replaced(where: {$0.isCompleted}, withResultOf: {$0.reset()})
        return Categories(allCategories: resetCategories, allClueBoxes: self.allClueBoxes.reset())
    }
    
    private func getNextCompletedCategoryOrder() -> Int {
        return self.sortedCompletedCategories.count
    }
    
    func completeCategory(categoryID: UUID) -> Categories {
        let newCategories: [Category] = self.allCategories.replaced(where: {$0.id == categoryID}, withResultOf: {$0.complete(orderCompleted: getNextCompletedCategoryOrder())})
        return Categories(allCategories: newCategories, allClueBoxes: self.allClueBoxes.completeSelectedClueBoxes())
    }
    
    func clickClueBox(clueBox: ClueBox) -> Categories {
        return Categories(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.clickClueBox(clueBox: clueBox))
    }
    
    func shuffleClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.shuffleClueBoxes())
    }
    
    func deselectAllClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.deselectAllClueBoxes())
    }
    
    func startShakingSelectedClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.startShakingSelectedClueBoxes())
    }
    
    func stopShakingSelectedClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.stopShakingSelectedClueBoxes())
    }
    
    func getSubmitBestMatch(selectedClueBoxIDs: [UUID], numCluesPerCategory: Int) -> SubmitResult? {
        let submitResults: [SubmitResult] = self.allCategories.map { category in
            SubmitResult(categoryID: category.id, numMatches: getNumSameElementsInArrays(lhs: selectedClueBoxIDs, rhs: category.getClueIDs()), numCluesPerCategory: numCluesPerCategory)
        }
        return submitResults.max(by: {a, b in a.numMatches < b.numMatches})
    }
}
