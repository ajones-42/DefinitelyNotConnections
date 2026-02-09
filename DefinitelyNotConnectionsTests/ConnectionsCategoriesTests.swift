//
//  ConnectionsCategoriesTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 04.02.26.
//

import Testing
import Foundation
@testable import DefinitelyNotConnections

@Suite struct ConnectionsCategoriesTests {
    // These tests will fail (as desired) if the createDefaultTestSetupInfo() properties change.
    
    // NumCompletedConnectionsCategories
    @Test func testNumCompletedConnectionsCategoriesNone() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.map({connectionsCategoryInfo in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        #expect(connectionsCategories.numCompletedConnectionsCategories == 0)
    }
    
    @Test func testNumCompletedConnectionsCategoriesAll() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.enumerated().map({(index, connectionsCategoryInfo) in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).withOrderCompleted(orderCompleted: index).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        #expect(connectionsCategories.numCompletedConnectionsCategories == 4)
    }
    
    @Test func testNumCompletedConnectionsCategoriesSome() {
        // Not using completeNConnectionsCategories or there's a circular dependence
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.enumerated().map({(index, connectionsCategoryInfo) in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).withOrderCompleted(orderCompleted: index < 2 ? index : nil).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        #expect(connectionsCategories.numCompletedConnectionsCategories == 2)
    }
    
    // sortedCompletedConnectionsCategories
    @Test func testsortedCompletedConnectionsCategoriesAddedInOrder() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.enumerated().map({(index, connectionsCategoryInfo) in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).withOrderCompleted(orderCompleted: index < 2 ? index : nil).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        #expect(connectionsCategories.sortedCompletedConnectionsCategories.first === connectionsCategoryList.first && connectionsCategories.sortedCompletedConnectionsCategories.last === connectionsCategoryList[1])
    }

    @Test func testsortedCompletedConnectionsCategoriesAddedOutOfOrder() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.enumerated().map({(index, connectionsCategoryInfo) in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).withOrderCompleted(orderCompleted: index < 2 ? 2 - index : nil).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        #expect(connectionsCategories.sortedCompletedConnectionsCategories.first === connectionsCategoryList[1] && connectionsCategories.sortedCompletedConnectionsCategories.last === connectionsCategoryList.first)
    }

    // Reset
    @Test func testResetAllCompletedConnectionsCategories() {
        let connectionsCategories: ConnectionsCategories = try! ConnectionsCategoriesBuilder().withCompleteAllConnectionsCategories().build()
        connectionsCategories.reset()
        #expect(connectionsCategories.numCompletedConnectionsCategories == 0)
    }
    
    @Test func testResetNoCompletedConnectionsCategories() {
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().build()
        connectionsCategories.reset()
        #expect(connectionsCategories.numCompletedConnectionsCategories == 0)
    }
    
    @Test func testResetSomeCompletedConnectionsCategories() {
        let connectionsCategories: ConnectionsCategories = try! ConnectionsCategoriesBuilder().withNCompletedConnectionsCategories(n: 2).build()
        connectionsCategories.reset()
        #expect(connectionsCategories.numCompletedConnectionsCategories == 0)
    }
    
    // Complete connectionsCategory
    @Test func testCompleteSingleConnectionsCategory() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.map({connectionsCategoryInfo in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[0].id)
        #expect(connectionsCategories.numCompletedConnectionsCategories == 1)
    }

    @Test func testCompleteMultipleConnectionsCategories() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.map({connectionsCategoryInfo in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[0].id)
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[1].id)
        #expect(connectionsCategories.numCompletedConnectionsCategories == 2)
    }
    
    @Test func testCompleteSameConnectionsCategoryTwice() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.map({connectionsCategoryInfo in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[0].id)
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[0].id)
        #expect(connectionsCategories.numCompletedConnectionsCategories == 1)
    }

    @Test func testCompleteUnknownConnectionsCategory() {
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().build()
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: UUID())
        #expect(connectionsCategories.numCompletedConnectionsCategories == 0)
    }
    
    // Indirectly test (private) getNextCompletedConnectionsCategoryOrder()
    @Test func testGetNextCompletedConnectionsCategoryOrderCompletedInOrder() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.map({connectionsCategoryInfo in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[0].id)
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[1].id)
        #expect(connectionsCategories.sortedCompletedConnectionsCategories.first === connectionsCategoryList.first && connectionsCategories.sortedCompletedConnectionsCategories.last === connectionsCategoryList[1])
    }
    
    @Test func testGetNextCompletedConnectionsCategoryOrderCompletedOutOfOrder() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = createDefaultTestSetupInfo().connectionsCategoryInfos
        let connectionsCategoryList: [ConnectionsCategory] = connectionsCategoryInfos.map({connectionsCategoryInfo in
            ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).build()
        })
        let connectionsCategories: ConnectionsCategories = ConnectionsCategoriesBuilder().withAllConnectionsCategories(allConnectionsCategories: connectionsCategoryList).build()
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[1].id)
        connectionsCategories.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryList[0].id)
        #expect(connectionsCategories.sortedCompletedConnectionsCategories.first === connectionsCategoryList[1] && connectionsCategories.sortedCompletedConnectionsCategories.last === connectionsCategoryList[0])
    }
}
