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
    
    func completeConnectionsCategory(connectionsCategoryID: UUID) throws {
        if let connectionsCategory = findConnectionsCategoryByID(connectionsCategoryID: connectionsCategoryID) {
            if connectionsCategory.isCompleted {
                print("ConnectionsCategory.completeConnectionsCategory: Category with ID \(connectionsCategoryID) is already completed.")
                throw ValidationError.alreadyCompletedConnectionsCategory
            }
            connectionsCategory.complete(orderCompleted: getNextCompletedConnectionsCategoryOrder())
        } else {
            print("ConnectionsCategory.completeConnectionsCategory: Could not find category with ID \(connectionsCategoryID).")
            throw ValidationError.unknownConnectionsCategoryID
        }
    }
}
