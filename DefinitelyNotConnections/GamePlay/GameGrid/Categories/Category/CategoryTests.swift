//
//  CategoryTests.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 03.02.26.
//

import Testing
@testable import DefinitelyNotConnections

@Suite struct CategoryTests {
    let completedCategory: Category = CategoryBuilder().withOrderCompleted(orderCompleted: 0).build()
    let uncompletedCategory: Category = CategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
    
    // Reset
    @Test func resetCompletedCategory() {
        let category: Category = completedCategory
        category.reset()
        #expect(category.isCompleted == false)
    }
    
    @Test func resetUncompletedCategory() {
        let category: Category = uncompletedCategory
        category.reset()
        #expect(category.isCompleted == false)
    }
    
    // Complete
    @Test func completeUncompletedCategory() {
        let category: Category = uncompletedCategory
        category.complete(orderCompleted: 0)
        #expect(category.isCompleted == true)
    }
}
