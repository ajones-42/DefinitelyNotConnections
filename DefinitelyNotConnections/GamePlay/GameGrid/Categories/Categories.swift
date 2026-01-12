//
//  Categories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation


struct Categories {
    let allCategories: [Category]

    var sortedCompletedCategories: [Category] {
        self.allCategories.filter( {$0.isCompleted} ).sorted(by: categoriesCompletedInIncreasingOrder)
    }
    var numCompletedCategories: Int {
        self.sortedCompletedCategories.count
    }
    
    func reset() -> Categories {
        let resetCategories: [Category] = self.allCategories.replaced(where: {$0.isCompleted}, withResultOf: {$0.reset()})
        return Categories(allCategories: resetCategories)
    }
    
    private func getNextCompletedCategoryOrder() -> Int {
        return self.sortedCompletedCategories.count
    }
    
    func completeCategory(category: Category) -> Categories {
        let newCategories: [Category] = self.allCategories.replaced(where: {$0.id == category.id}, withResultOf: {$0.complete(orderCompleted: getNextCompletedCategoryOrder())})
        return Categories(allCategories: newCategories)
    }
}
