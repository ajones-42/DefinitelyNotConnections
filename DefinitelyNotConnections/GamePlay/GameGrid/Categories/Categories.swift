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
        return self.numCompletedCategories
    }
    
    func completeCategory(categoryID: UUID) {
        if let category = self.allCategories.first(where: {category in category.id == categoryID}) {
            category.complete(orderCompleted: getNextCompletedCategoryOrder())
        }
    }
}

// Add functions for testing
extension Categories {
    internal func completeFirstNCategories(n: Int) throws {
        let totalNumCategories: Int = self.allCategories.count
        guard (n >= 0 && n <= totalNumCategories) else {
            print("Categories.completeNcategories: n must be positive, and less than or equal to total number of clueBoxes (\(totalNumCategories))")
            throw ValidationError.invalidInput
        }
        self.allCategories.enumerated().forEach({(index, category) in
            if index < n {
                category.complete(orderCompleted: index)
            }
        })
    }
}
