//
//  MiscFunctionsTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 05.02.26.
//

import Testing
@testable import DefinitelyNotConnections

struct MiscFunctionsTests {

    // connectionsCategoriesCompletedInIncreasingOrder()
    @Test func testConnectionsCategoriesCompletedInIncreasingOrder() {
        let connectionsCategory1: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: 1).build()
        let connectionsCategory2: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: 2).build()
        #expect(connectionsCategoriesCompletedInIncreasingOrder(connectionsCategory1: connectionsCategory1, connectionsCategory2: connectionsCategory2) == true)
    }
    
    @Test func testConnectionsCategoriesNotCompletedInIncreasingOrder() {
        let connectionsCategory1: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: 1).build()
        let connectionsCategory2: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: 2).build()
        #expect(connectionsCategoriesCompletedInIncreasingOrder(connectionsCategory1: connectionsCategory2, connectionsCategory2: connectionsCategory1) == false)
    }
    
    @Test func testConnectionsCategoriesCompletedInIncreasingOrderFirstUncomplete() {
        let connectionsCategory1: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        let connectionsCategory2: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: 2).build()
        #expect(connectionsCategoriesCompletedInIncreasingOrder(connectionsCategory1: connectionsCategory1, connectionsCategory2: connectionsCategory2) == false)
    }
    
    @Test func testConnectionsCategoriesCompletedInIncreasingOrderSecondUncomplete() {
        let connectionsCategory1: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: 1).build()
        let connectionsCategory2: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        #expect(connectionsCategoriesCompletedInIncreasingOrder(connectionsCategory1: connectionsCategory1, connectionsCategory2: connectionsCategory2) == true)
    }
    
    @Test func testConnectionsCategoriesCompletedInIncreasingOrderNeitherCompleteOrderIrrelevant() {
        let connectionsCategory1: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        let connectionsCategory2: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        #expect(connectionsCategoriesCompletedInIncreasingOrder(connectionsCategory1: connectionsCategory1, connectionsCategory2: connectionsCategory2) == connectionsCategoriesCompletedInIncreasingOrder(connectionsCategory1: connectionsCategory2, connectionsCategory2: connectionsCategory1))
    }

}
