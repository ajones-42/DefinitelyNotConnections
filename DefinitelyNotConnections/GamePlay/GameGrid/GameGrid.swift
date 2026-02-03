//
//  Categories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation

@Observable
class GameGrid {
    private(set) var allCategories: Categories
    private(set) var allClueBoxes: AllClueBoxes
    let gameProperties: GameProperties
    
    init(setupInfo: SetupInfo, gameProperties: GameProperties) {
        self.allCategories = Categories(setupInfo: setupInfo)
        self.gameProperties = gameProperties
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    init(allCategories: Categories, allClueBoxes: AllClueBoxes, gameProperties: GameProperties) {
        self.allCategories = allCategories
        self.allClueBoxes = allClueBoxes
        self.gameProperties = gameProperties
    }
    
    func reset() {
        self.allCategories.reset()
        self.allClueBoxes.reset()
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.allClueBoxes.selectedClueBoxes
    }
    
    func getCategories() -> [Category] {
        return self.allCategories.allCategories
    }
    
    func getNumCompletedCategories() -> Int {
        return self.allCategories.numCompletedCategories
    }
    
    func getSubmitIsClickable() -> Bool {
        return self.allClueBoxes.submitIsClickable
    }
    
    func shakeSelectedClueBoxesMomentarily(duration: TimeInterval) {
        self.allClueBoxes.shakeSelectedClueBoxesMomentarily(duration: duration)
    }
    
    func completeCategory(categoryID: UUID) {
        self.allCategories.completeCategory(categoryID: categoryID)
        self.allClueBoxes.completeClueBoxesByCategoryID(categoryID: categoryID)
    }
}

// Add functions for testing
extension GameGrid {
    func completeNCategories(n: Int) throws {
        let allCategoryIDs: [UUID] = self.allCategories.getCategoryIDs()
        let totalNumCategories: Int = allCategoryIDs.count
        guard (n <= totalNumCategories) else {
            print("GameGrid.completeNCategories: n must be less than or equal to total number of clueBoxes (\(totalNumCategories))")
            throw ValidationError.invalidInput
        }
        allCategoryIDs.enumerated().forEach({(index, categoryID) in
            if index < n - 1 {
                completeCategory(categoryID: categoryID)
            }
        })
    }
}
