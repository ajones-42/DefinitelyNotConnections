//
//  Categories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation

@Observable
class GameGrid {
    private(set) var allCategories: [Category]
    private(set) var allClueBoxes: AllClueBoxes
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
        self.allCategories = createCategories(categoryInfos: setupInfo.categoryInfos)
        self.gameProperties = gameProperties
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    init(allCategories: [Category], allClueBoxes: AllClueBoxes, gameProperties: GameProperties) {
        self.allCategories = allCategories
        self.allClueBoxes = allClueBoxes
        self.gameProperties = gameProperties
    }
    
    func reset() {
        self.allCategories.forEach({category in
            category.reset()
        })
        self.allClueBoxes.reset()
    }
    
    private func getNextCompletedCategoryOrder() -> Int {
        return self.sortedCompletedCategories.count
    }
    
    func completeCategory(categoryID: UUID) {
        if let category = self.allCategories.first(where: {category in category.id == categoryID}) {
            category.complete(orderCompleted: getNextCompletedCategoryOrder())
        }
        self.allClueBoxes.completeSelectedClueBoxes()
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.selectedClueBoxes
    }
    
    func getSubmitIsClickable() -> Bool {
        return self.allClueBoxes.submitIsClickable
    }
    
    func startShakingSelectedClueBoxes() {
        self.allClueBoxes.startShakingSelectedClueBoxes()
    }
    
    func stopShakingSelectedClueBoxes() {
        self.allClueBoxes.stopShakingSelectedClueBoxes()
    }
    
    func getSubmitBestMatch() -> SubmitResult? {
        let submitResults: [SubmitResult] = self.allCategories.map {category in
            SubmitResult(categoryID: category.id, numMatches: getNumSameElementsInArrays(lhs: self.allClueBoxes.selectedClueBoxIDs, rhs: category.getClueIDs()), numCluesPerCategory: self.gameProperties.numCluesPerCategory)
        }
        return submitResults.max(by: {a, b in a.numMatches < b.numMatches})
    }
}
