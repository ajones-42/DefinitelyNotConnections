//
//  Categories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation

@Observable
class Categories {
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
    
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.remainingClueBoxes
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.selectedClueBoxes
    }
    
    func clickClueBox(clueBox: ClueBox) {
        self.allClueBoxes.clickClueBox(clueBox: clueBox)
    }
    
    func shuffleClueBoxes() {
        self.allClueBoxes.shuffleClueBoxes()
    }
    
    func getSubmitIsClickable() -> Bool {
        return self.allClueBoxes.submitIsClickable
    }
    
    func getDeselectAllIsClickable() -> Bool {
        return self.allClueBoxes.deselectAllIsClickable
    }
    
    func deselectAllClueBoxes() {
        self.allClueBoxes.deselectAllClueBoxes()
    }
    
    func startShakingSelectedClueBoxes() {
        self.allClueBoxes.startShakingSelectedClueBoxes()
    }
    
    func stopShakingSelectedClueBoxes() {
        self.allClueBoxes.stopShakingSelectedClueBoxes()
    }
    
    func getSubmitBestMatch(selectedClueBoxIDs: [UUID]) -> SubmitResult? {
        let submitResults: [SubmitResult] = self.allCategories.map {category in
            SubmitResult(categoryID: category.id, numMatches: getNumSameElementsInArrays(lhs: selectedClueBoxIDs, rhs: category.getClueIDs()), numCluesPerCategory: self.gameProperties.numCluesPerCategory)
        }
        return submitResults.max(by: {a, b in a.numMatches < b.numMatches})
    }
}
