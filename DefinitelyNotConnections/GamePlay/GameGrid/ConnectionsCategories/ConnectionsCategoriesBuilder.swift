//
//  ConnectionsCategoriesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 29.01.26.
//

import Foundation

class ConnectionsCategoriesBuilder {
    var allConnectionsCategories: [ConnectionsCategory]
    
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
    
    func build() -> ConnectionsCategories {
        return ConnectionsCategories(allConnectionsCategories: self.allConnectionsCategories)
    }
}
