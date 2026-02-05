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
    
    func build() -> Categories {
        return Categories(allCategories: self.allCategories)
    }
}
