//
//  CategoryTests.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 03.02.26.
//

import Testing
@testable import DefinitelyNotConnections

@Suite struct CategoryTests {
    // Reset
    @Test func resetCompletedCategory() {
        let category: Category = CategoryBuilder().withOrderCompleted(orderCompleted: 0).build()
        category.reset()
        #expect(category.isCompleted == false)
    }
    
    @Test func resetUncompletedCategory() {
        let category: Category = CategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        category.reset()
        #expect(category.isCompleted == false)
    }
    
    // Complete
    @Test func completeUncompletedCategory() {
        let category: Category = CategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        category.complete(orderCompleted: 0)
        #expect(category.isCompleted == true)
    }
}
