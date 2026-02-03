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
    
    func getCategoryIDs() -> [UUID] {
        return self.allCategories.map({category in
            category.id
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

// Add functions for testing
extension Categories {
    private func completeNCategories(n: Int) throws {
        let totalNumCategories: Int = self.allCategories.count
        guard (n <= totalNumCategories) else {
            print("Categories.completeNcategories: n must be less than or equal to total number of clueBoxes (\(totalNumCategories))")
            throw ValidationError.invalidInput
        }
        self.allCategories.enumerated().forEach({(index, category) in
            if index < n {
                category.complete(orderCompleted: index)
            }
        })
    }
}
