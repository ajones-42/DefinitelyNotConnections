//
//  ConnectionsCategories.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 29.01.26.
//

import Foundation

@Observable
class ConnectionsCategories {
    private(set) var allConnectionsCategories: [ConnectionsCategory]
    
    var sortedCompletedConnectionsCategories: [ConnectionsCategory] {
        self.allConnectionsCategories.filter({
            connectionsCategory in connectionsCategory.isCompleted
        }).sorted(by: connectionsCategoriesCompletedInIncreasingOrder)
    }
    var numCompletedConnectionsCategories: Int {
        self.sortedCompletedConnectionsCategories.count
    }
    
    init(setupInfo: SetupInfo) {
        self.allConnectionsCategories = createConnectionsCategories(connectionsCategoryInfos: setupInfo.connectionsCategoryInfos)
    }
    
    init(allConnectionsCategories: [ConnectionsCategory]) {
        self.allConnectionsCategories = allConnectionsCategories
    }
    
    func reset() {
        self.allConnectionsCategories.forEach({connectionsCategory in
            connectionsCategory.reset()
        })
    }
    
    func getConnectionsCategoryIDs() -> [UUID] {
        return self.allConnectionsCategories.map({connectionsCategory in
            connectionsCategory.id
        })
    }
    
    private func findConnectionsCategoryByID(connectionsCategoryID: UUID) -> ConnectionsCategory? {
        return self.allConnectionsCategories.first(where: {connectionsCategory in connectionsCategory.id == connectionsCategoryID})
    }
    
    private func getNextCompletedConnectionsCategoryOrder() -> Int {
        return self.numCompletedConnectionsCategories
    }
    
    func completeConnectionsCategory(connectionsCategoryID: UUID) {
        if let connectionsCategory = findConnectionsCategoryByID(connectionsCategoryID: connectionsCategoryID) {
            connectionsCategory.complete(orderCompleted: getNextCompletedConnectionsCategoryOrder())
        }
    }
}

// Add functions for testing
extension ConnectionsCategories {
    internal func completeFirstNConnectionsCategories(n: Int) throws {
        let totalNumConnectionsCategories: Int = self.allConnectionsCategories.count
        guard (n >= 0 && n <= totalNumConnectionsCategories) else {
            print("ConnectionsCategories.completeNConnectionsCategories: n must be positive, and less than or equal to total number of clueBoxes (\(totalNumConnectionsCategories))")
            throw ValidationError.invalidInput
        }
        self.allConnectionsCategories.enumerated().forEach({(index, connectionsCategory) in
            if index < n {
                connectionsCategory.complete(orderCompleted: index)
            }
        })
    }
}
