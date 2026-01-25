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
        self.allCategories.filter({
            category in category.isCompleted
        }).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    var numCompletedCategories: Int {
        self.sortedCompletedCategories.count
    }
    
    static private func setupCategories(setupInfo: SetupInfo) -> [Category] {
        return setupInfo.categoryInfos.enumerated().map{(index, categoryInfo) in
            Category(id: index, categoryInfo: categoryInfo)
        }
    }
    
    init(setupInfo: SetupInfo, gameProperties: GameProperties) {
        self.allCategories = Categories.setupCategories(setupInfo: setupInfo)
        self.gameProperties = gameProperties
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    init(allCategories: [Category], allClueBoxes: AllClueBoxes) {
        self.allCategories = allCategories
        self.allClueBoxes = allClueBoxes
    }
    
    func reset() -> Categories {
        let resetCategories: [Category] = self.allCategories.replaced(where: {category in category.isCompleted}, withResultOf: {category in category.reset()})
        return Categories(allCategories: resetCategories, allClueBoxes: self.allClueBoxes.reset())
    }
    
    private func getNextCompletedCategoryOrder() -> Int {
        return self.sortedCompletedCategories.count
    }
    
    func completeCategory(categoryID: UUID) -> Categories {
        let newCategories: [Category] = self.allCategories.replaced(where: {category in category.id == categoryID}, withResultOf: {category in category.complete(orderCompleted: getNextCompletedCategoryOrder())})
        return Categories(allCategories: newCategories, allClueBoxes: self.allClueBoxes.completeSelectedClueBoxes())
    }
    
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.remainingClueBoxes
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.selectedClueBoxes
    }
    
    func clickClueBox(clueBox: ClueBox) -> Categories {
        return Categories(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.clickClueBox(clueBoxToClick: clueBox))
    }
    
    func shuffleClueBoxes() -> Categories {
        return Categories(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.shuffleClueBoxes())
    }
    
    func getSubmitIsClickable() -> Bool {
        return self.allClueBoxes.submitIsClickable
    }
    
    func getDeselectAllIsClickable() -> Bool {
        return self.allClueBoxes.deselectAllIsClickable
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
        let submitResults: [SubmitResult] = self.allCategories.map {category in
            SubmitResult(categoryID: category.id, numMatches: getNumSameElementsInArrays(lhs: selectedClueBoxIDs, rhs: category.getClueIDs()), numCluesPerCategory: numCluesPerCategory)
        }
        return submitResults.max(by: {a, b in a.numMatches < b.numMatches})
    }
}
