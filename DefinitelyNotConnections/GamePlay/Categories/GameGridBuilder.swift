//
//  CategoriesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class GameGridBuilder {
    var allCategories: [Category]
    var gameProperties: GameProperties
    var allClueBoxes: AllClueBoxes
    
    init(setupInfo: SetupInfo) {
        self.allCategories = createCategories(categoryInfos: setupInfo.categoryInfos)
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    init() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        self.allCategories = createCategories(categoryInfos: setupInfo.categoryInfos)
        self.gameProperties = GameProperties(setupInfo: setupInfo)
        self.allClueBoxes = AllClueBoxes(setupInfo: setupInfo, gameProperties: self.gameProperties, shuffled: true)
    }
    
    func withAllCategories(allCategories: [Category]) -> GameGridBuilder {
        self.allCategories = allCategories
        return self
    }
    
    func withAllClueBoxes(allClueBoxes: AllClueBoxes) -> GameGridBuilder {
        self.allClueBoxes = allClueBoxes
        return self
    }
    
    func withGameProperties(gameProperties: GameProperties) -> GameGridBuilder {
        self.gameProperties = gameProperties
        return self
    }
    
    func completeFirstNCategories(n: Int) throws -> GameGridBuilder {
        let numCategories = self.allCategories.count
        guard (n >= 0 && n <= numCategories) else {
            print("CategoriesBuilder.completeFirstNCategories: Invalid value of n (\(n)). It must be greater than zero, and less than or equal to the number of categories (\(numCategories))")
            throw ValidationError.invalidInput
        }
        self.allCategories.enumerated().forEach({(index, category) in
            if index + 1 <= n {
                category.complete(orderCompleted: index)
            }
        })
        return self
    }
    
    func completeAllCategories() -> GameGridBuilder {
        return try! completeFirstNCategories(n: self.gameProperties.numCategories)
    }
    
    func build() -> GameGrid {
        return GameGrid(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes, gameProperties: self.gameProperties)
    }
}
