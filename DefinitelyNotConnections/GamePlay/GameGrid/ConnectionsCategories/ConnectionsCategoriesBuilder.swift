//
//  ConnectionsCategoriesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 29.01.26.
//

import Foundation

// Add functions for testing
extension ConnectionsCategories {
    fileprivate func completeFirstNConnectionsCategories(n: Int) throws {
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
    
    fileprivate func completeAllConnectionsCategories() {
        let totalNumConnectionsCategories: Int = self.allConnectionsCategories.count
        try! completeFirstNConnectionsCategories(n: totalNumConnectionsCategories)
    }
}

class ConnectionsCategoriesBuilder {
    var allConnectionsCategories: [ConnectionsCategory]
    var numCompletedConnectionsCategories: Int = 0
    var completeAllConnectionsCategories: Bool = false
    
    init(setupInfo: SetupInfo) {
        self.allConnectionsCategories = createConnectionsCategories(connectionsCategoryInfos: setupInfo.connectionsCategoryInfos)
    }
    
    init() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        self.allConnectionsCategories = createConnectionsCategories(connectionsCategoryInfos: setupInfo.connectionsCategoryInfos)
    }
    
    func withAllConnectionsCategories(allConnectionsCategories: [ConnectionsCategory]) -> ConnectionsCategoriesBuilder {
        self.allConnectionsCategories = allConnectionsCategories
        return self
    }
    
    func withNCompletedConnectionsCategories(n: Int) throws -> ConnectionsCategoriesBuilder {
        guard (self.completeAllConnectionsCategories == false) else {
            print("ConnectionsCategoriesBuilder.withNCompletedConnectionsCategories: completeAllConnectionsCategories already set. Cannot use both in the same ConnectionsCategoriesBuilder.")
            throw ValidationError.invalidInput
        }
        self.numCompletedConnectionsCategories = n
        return self
    }
    
    func withCompleteAllConnectionsCategories() throws -> ConnectionsCategoriesBuilder {
        guard (self.numCompletedConnectionsCategories == 0) else {
            print("ConnectionsCategoriesBuilder.withCompleteAllConnectionsCategories: numCompletedConnectionsCategories already set. Cannot use both in the same ConnectionsCategoriesBuilder.")
            throw ValidationError.invalidInput
        }
        self.completeAllConnectionsCategories = true
        return self
    }
    
    func build() -> ConnectionsCategories {
        let connectionsCategories: ConnectionsCategories = ConnectionsCategories(allConnectionsCategories: self.allConnectionsCategories)
        
        if self.completeAllConnectionsCategories {
            connectionsCategories.completeAllConnectionsCategories()
        } else if self.numCompletedConnectionsCategories > 0 {
            try! connectionsCategories.completeFirstNConnectionsCategories(n: self.numCompletedConnectionsCategories)
        }

        return connectionsCategories
    }
}
