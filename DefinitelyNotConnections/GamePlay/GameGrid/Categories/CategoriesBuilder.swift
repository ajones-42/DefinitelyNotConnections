//
//  CategoriesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 29.01.26.
//

import Foundation

class CategoriesBuilder {
    var allCategories: [Category]
    
    init(setupInfo: SetupInfo) {
        self.allCategories = createCategories(categoryInfos: setupInfo.categoryInfos)
    }
    
    init() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        self.allCategories = createCategories(categoryInfos: setupInfo.categoryInfos)
    }
    
    func withAllCategories(allCategories: [Category]) -> CategoriesBuilder {
        self.allCategories = allCategories
        return self
    }
    
    func completeFirstNCategories(n: Int) throws -> CategoriesBuilder {
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
    
    func completeAllCategories(gameProperties: GameProperties) -> CategoriesBuilder {
        return try! completeFirstNCategories(n: gameProperties.numCategories)
    }
    
    func build() -> Categories {
        return Categories(allCategories: self.allCategories)
    }
}
