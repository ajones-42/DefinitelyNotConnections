//
//  Categories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 29.01.26.
//

import Foundation

@Observable
class Categories {
    private(set) var allCategories: [Category]
    
    var sortedCompletedCategories: [Category] {
        self.allCategories.filter({
            category in category.isCompleted
        }).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    var numCompletedCategories: Int {
        self.sortedCompletedCategories.count
    }
    
    init(setupInfo: SetupInfo) {
        self.allCategories = createCategories(categoryInfos: setupInfo.categoryInfos)
    }
    
    init(allCategories: [Category]) {
        self.allCategories = allCategories
    }
    
    func reset() {
        self.allCategories.forEach({category in
            category.reset()
        })
    }
    
    
    private func getNextCompletedCategoryOrder() -> Int {
        return self.sortedCompletedCategories.count
    }
    
    func completeCategory(categoryID: UUID) {
        if let category = self.allCategories.first(where: {category in category.id == categoryID}) {
            category.complete(orderCompleted: getNextCompletedCategoryOrder())
        }
    }
}
