//
//  ConnectionsCategoryTests.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 03.02.26.
//

import Testing
@testable import DefinitelyNotConnections

@Suite struct ConnectionsCategoryTests {
    // Reset
    @Test func resetCompletedConnectionsCategory() {
        let connectionsCategory: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: 0).build()
        connectionsCategory.reset()

        #expect(connectionsCategory.isCompleted == false)
    }
    
    @Test func resetUncompletedConnectionsCategory() {
        let connectionsCategory: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        connectionsCategory.reset()

        #expect(connectionsCategory.isCompleted == false)
    }
    
    // Complete
    @Test func completeUncompletedConnectionsCategory() {
        let connectionsCategory: ConnectionsCategory = ConnectionsCategoryBuilder().withOrderCompleted(orderCompleted: nil).build()
        connectionsCategory.complete(orderCompleted: 0)

        #expect(connectionsCategory.isCompleted == true)
    }
}
