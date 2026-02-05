//
//  CategoriesTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 04.02.26.
//

import Testing
import Foundation
@testable import DefinitelyNotConnections

@Suite struct CategoriesTests {
    // These tests will fail (as desired) if the createDefaultTestSetupInfo() properties change.
    
    // NumCompletedCategories
    @Test func testNumCompletedCategoriesNone() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.map({categoryInfo in
            CategoryBuilder(categoryInfo: categoryInfo).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        #expect(categories.numCompletedCategories == 0)
    }
    
    @Test func testNumCompletedCategoriesAll() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.enumerated().map({(index, categoryInfo) in
            CategoryBuilder(categoryInfo: categoryInfo).withOrderCompleted(orderCompleted: index).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        #expect(categories.numCompletedCategories == 4)
    }
    
    @Test func testNumCompletedCategoriesSome() {
        // Not using completeNCategories or there's a circular dependence
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.enumerated().map({(index, categoryInfo) in
            CategoryBuilder(categoryInfo: categoryInfo).withOrderCompleted(orderCompleted: index < 2 ? index : nil).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        #expect(categories.numCompletedCategories == 2)
    }
    
    // sortedCompletedCategories
    @Test func testsortedCompletedCategoriesAddedInOrder() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.enumerated().map({(index, categoryInfo) in
            CategoryBuilder(categoryInfo: categoryInfo).withOrderCompleted(orderCompleted: index < 2 ? index : nil).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        #expect(categories.sortedCompletedCategories.first === categoryList.first && categories.sortedCompletedCategories.last === categoryList[1])
    }

    @Test func testsortedCompletedCategoriesAddedOutOfOrder() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.enumerated().map({(index, categoryInfo) in
            CategoryBuilder(categoryInfo: categoryInfo).withOrderCompleted(orderCompleted: index < 2 ? 2 - index : nil).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        #expect(categories.sortedCompletedCategories.first === categoryList[1] && categories.sortedCompletedCategories.last === categoryList.first)
    }
    
    // completeNCategories
    @Test func testcompleteZeroCategories() {
        let categories: Categories = CategoriesBuilder().build()
        #expect(throws: Never.self) {
            try categories.completeFirstNCategories(n: 0)
        }
        #expect(categories.numCompletedCategories == 0)
    }

    @Test func testcompleteOneCategory() {
        let categories: Categories = CategoriesBuilder().build()
        #expect(throws: Never.self) {
            try categories.completeFirstNCategories(n: 1)
        }
        #expect(categories.numCompletedCategories == 1)
    }
    
    @Test func testcompleteAllCategories() {
        let categories: Categories = CategoriesBuilder().build()
        #expect(throws: Never.self) {
            try categories.completeFirstNCategories(n: 4)
        }
        #expect(categories.numCompletedCategories == 4)
    }
    
    @Test func testcompleteTooManyCategories() {
        let categories: Categories = CategoriesBuilder().build()
        #expect(throws: ValidationError.invalidInput.self) {
            try categories.completeFirstNCategories(n: 5)
        }
    }
    
    @Test func testcompleteNegativeCategories() {
        let categories: Categories = CategoriesBuilder().build()
        #expect(throws: ValidationError.invalidInput.self) {
            try categories.completeFirstNCategories(n: -1)
        }
    }

    // Reset
    @Test func testResetAllCompletedCategories() {
        let categories: Categories = CategoriesBuilder().build()
        try! categories.completeFirstNCategories(n: 4)
        categories.reset()
        #expect(categories.numCompletedCategories == 0)
    }
    
    @Test func testResetNoCompletedCategories() {
        let categories: Categories = CategoriesBuilder().build()
        categories.reset()
        #expect(categories.numCompletedCategories == 0)
    }
    
    @Test func testResetSomeCompletedCategories() {
        let categories: Categories = CategoriesBuilder().build()
        try! categories.completeFirstNCategories(n: 2)
        categories.reset()
        #expect(categories.numCompletedCategories == 0)
    }
    
    // Complete category
    @Test func testCompleteSingleCategory() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.map({categoryInfo in
            CategoryBuilder(categoryInfo: categoryInfo).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        categories.completeCategory(categoryID: categoryList[0].id)
        #expect(categories.numCompletedCategories == 1)
    }

    @Test func testCompleteMultipleCategories() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.map({categoryInfo in
            CategoryBuilder(categoryInfo: categoryInfo).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        categories.completeCategory(categoryID: categoryList[0].id)
        categories.completeCategory(categoryID: categoryList[1].id)
        #expect(categories.numCompletedCategories == 2)
    }
    
    @Test func testCompleteSameCategoryTwice() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.map({categoryInfo in
            CategoryBuilder(categoryInfo: categoryInfo).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        categories.completeCategory(categoryID: categoryList[0].id)
        categories.completeCategory(categoryID: categoryList[0].id)
        #expect(categories.numCompletedCategories == 1)
    }

    @Test func testCompleteUnknownCategory() {
        let categories: Categories = CategoriesBuilder().build()
        categories.completeCategory(categoryID: UUID())
        #expect(categories.numCompletedCategories == 0)
    }
    
    // Indirectly test (private) getNextCompletedCategoryOrder()
    @Test func testGetNextCompletedCategoryOrderCompletedInOrder() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.map({categoryInfo in
            CategoryBuilder(categoryInfo: categoryInfo).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        categories.completeCategory(categoryID: categoryList[0].id)
        categories.completeCategory(categoryID: categoryList[1].id)
        #expect(categories.sortedCompletedCategories.first === categoryList.first && categories.sortedCompletedCategories.last === categoryList[1])
    }
    
    @Test func testGetNextCompletedCategoryOrderCompletedOutOfOrder() {
        let categoryInfos: [CategoryInfo] = createDefaultTestSetupInfo().categoryInfos
        let categoryList: [Category] = categoryInfos.map({categoryInfo in
            CategoryBuilder(categoryInfo: categoryInfo).build()
        })
        let categories: Categories = CategoriesBuilder().withAllCategories(allCategories: categoryList).build()
        categories.completeCategory(categoryID: categoryList[1].id)
        categories.completeCategory(categoryID: categoryList[0].id)
        #expect(categories.sortedCompletedCategories.first === categoryList[1] && categories.sortedCompletedCategories.last === categoryList[0])
    }
}
