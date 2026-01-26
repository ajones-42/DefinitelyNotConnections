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
    let gameProperties: GameProperties

    var sortedCompletedCategories: [Category] {
        self.allCategories.filter({
            category in category.isCompleted
        }).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    var numCompletedCategories: Int {
        self.sortedCompletedCategories.count
    }
    
    init(setupInfo: SetupInfo, gameProperties: GameProperties) {
        self.allCategories = createCategories(setupInfo: setupInfo)
        self.gameProperties = gameProperties
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    init(allCategories: [Category], allClueBoxes: AllClueBoxes, gameProperties: GameProperties) {
        self.allCategories = allCategories
        self.allClueBoxes = allClueBoxes
        self.gameProperties = gameProperties
    }
    
    private func recompute(allCategories: [Category], allClueBoxes: AllClueBoxes) -> Categories {
        return Categories(allCategories: allCategories, allClueBoxes: allClueBoxes, gameProperties: self.gameProperties)
    }
    
    func reset() -> Categories {
        let resetCategories: [Category] = self.allCategories.replaced(where: {category in category.isCompleted}, withResultOf: {category in category.reset()})
        return recompute(allCategories: resetCategories, allClueBoxes: self.allClueBoxes.reset())
    }
    
    private func getNextCompletedCategoryOrder() -> Int {
        return self.sortedCompletedCategories.count
    }
    
    func completeCategory(categoryID: UUID) -> Categories {
        let newCategories: [Category] = self.allCategories.replaced(where: {category in category.id == categoryID}, withResultOf: {category in category.complete(orderCompleted: getNextCompletedCategoryOrder())})
        return recompute(allCategories: newCategories, allClueBoxes: self.allClueBoxes.completeSelectedClueBoxes())
    }
    
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.remainingClueBoxes
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.selectedClueBoxes
    }
    
    func clickClueBox(clueBox: ClueBox) -> Categories {
        return recompute(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.clickClueBox(clueBoxToClick: clueBox))
    }
    
    func shuffleClueBoxes() -> Categories {
        return recompute(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.shuffleClueBoxes())
    }
    
    func getSubmitIsClickable() -> Bool {
        return self.allClueBoxes.submitIsClickable
    }
    
    func getDeselectAllIsClickable() -> Bool {
        return self.allClueBoxes.deselectAllIsClickable
    }
    
    func deselectAllClueBoxes() -> Categories {
        return recompute(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.deselectAllClueBoxes())
    }
    
    func startShakingSelectedClueBoxes() -> Categories {
        return recompute(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.startShakingSelectedClueBoxes())
    }
    
    func stopShakingSelectedClueBoxes() -> Categories {
        return recompute(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes.stopShakingSelectedClueBoxes())
    }
    
    func getSubmitBestMatch(selectedClueBoxIDs: [UUID]) -> SubmitResult? {
        let submitResults: [SubmitResult] = self.allCategories.map {category in
            SubmitResult(categoryID: category.id, numMatches: getNumSameElementsInArrays(lhs: selectedClueBoxIDs, rhs: category.getClueIDs()), numCluesPerCategory: self.gameProperties.numCluesPerCategory)
        }
        return submitResults.max(by: {a, b in a.numMatches < b.numMatches})
    }
}
