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
    
    func startShakingSelectedClueBoxes() {
        self.allClueBoxes.startShakingSelectedClueBoxes()
    }
    
    func stopShakingSelectedClueBoxes() {
        self.allClueBoxes.stopShakingSelectedClueBoxes()
    }
    
    func completeCategory(categoryID: UUID) {
        self.allCategories.completeCategory(categoryID: categoryID)
        self.allClueBoxes.completeClueBoxesByCategoryID(categoryID: categoryID)
    }
}
