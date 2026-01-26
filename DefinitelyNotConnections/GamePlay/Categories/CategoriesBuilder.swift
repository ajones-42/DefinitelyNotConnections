//
//  CategoriesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class CategoriesBuilder {
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
    
    func withAllCategories(allCategories: [Category]) -> CategoriesBuilder {
        self.allCategories = allCategories
        return self
    }
    
    func withAllClueBoxes(allClueBoxes: AllClueBoxes) -> CategoriesBuilder {
        self.allClueBoxes = allClueBoxes
        return self
    }
    
    func withGameProperties(gameProperties: GameProperties) -> CategoriesBuilder {
        self.gameProperties = gameProperties
        return self
    }
    
    func completeAllCategories() -> CategoriesBuilder {
        self.allCategories = self.allCategories.enumerated().map({(index, category) in
            category.complete(orderCompleted: index)
        })
        return self
    }
    
    func build() -> Categories {
        return Categories(allCategories: self.allCategories, allClueBoxes: self.allClueBoxes, gameProperties: self.gameProperties)
    }
}
