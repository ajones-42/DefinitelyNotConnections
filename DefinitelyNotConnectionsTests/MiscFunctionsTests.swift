//
//  MiscFunctionsTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 05.02.26.
//

import Testing
@testable import DefinitelyNotConnections

struct MiscFunctionsTests {

    // categoriesCompletedInIncreasingOrder()
    @Test func testCategoriesCompletedInIncreasingOrder() {
        let category1: Category = CategoryBuilder().withOrderCompleted(orderCompleted: 1).build()
        let category2: Category = CategoryBuilder().withOrderCompleted(orderCompleted: 2).build()
        #expect(categoriesCompletedInIncreasingOrder(category1: category1, category2: category2) == true)
    }
    
    @Test func testCategoriesNotCompletedInIncreasingOrder() {
        let category1: Category = CategoryBuilder().withOrderCompleted(orderCompleted: 1).build()
        let category2: Category = CategoryBuilder().withOrderCompleted(orderCompleted: 2).build()
        #expect(categoriesCompletedInIncreasingOrder(category1: category2, category2: category1) == false)
    }
    
    @Test func testCategoriesCompletedInIncreasingOrderFirstUncomplete() {
        let category1: Category = CategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        let category2: Category = CategoryBuilder().withOrderCompleted(orderCompleted: 2).build()
        #expect(categoriesCompletedInIncreasingOrder(category1: category1, category2: category2) == false)
    }
    
    @Test func testCategoriesCompletedInIncreasingOrderSecondUncomplete() {
        let category1: Category = CategoryBuilder().withOrderCompleted(orderCompleted: 1).build()
        let category2: Category = CategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        #expect(categoriesCompletedInIncreasingOrder(category1: category1, category2: category2) == true)
    }
    
    @Test func testCategoriesCompletedInIncreasingOrderNeitherCompleteOrderIrrelevant() {
        let category1: Category = CategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        let category2: Category = CategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        #expect(categoriesCompletedInIncreasingOrder(category1: category1, category2: category2) == categoriesCompletedInIncreasingOrder(category1: category2, category2: category1))
    }

}
