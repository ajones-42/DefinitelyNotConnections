//
//  ConnectionsCategoryBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation
import SwiftUI

class ConnectionsCategoryBuilder {
    var name: String
    var clueInfos: [ClueInfo]
    var colour: Color
    var id: UUID
    var orderCompleted: Int?
    
    init() {
        self.name = "A ConnectionsCategory"
        self.clueInfos = []
        self.colour = .red
        self.id = UUID()
        self.orderCompleted = nil
    }
    
    init(connectionsCategoryInfo: ConnectionsCategoryInfo) {
        self.name = connectionsCategoryInfo.name
        self.colour = connectionsCategoryInfo.colour
        self.id = connectionsCategoryInfo.id
        self.clueInfos = connectionsCategoryInfo.clueInfos
        self.orderCompleted = nil
    }

    func withName(name: String) -> ConnectionsCategoryBuilder {
        self.name = name
        return self
    }
    
    func withClueInfos(clueInfos: [ClueInfo]) -> ConnectionsCategoryBuilder {
        self.clueInfos = clueInfos
        return self
    }
    
    func withColour(colour: Color) -> ConnectionsCategoryBuilder {
        self.colour = colour
        return self
    }
    
    func withID(id: UUID) -> ConnectionsCategoryBuilder {
        self.id = id
        return self
    }
    
    func withOrderCompleted(orderCompleted: Int?) -> ConnectionsCategoryBuilder {
        self.orderCompleted = orderCompleted
        return self
    }
    
    func build() -> ConnectionsCategory {
        return ConnectionsCategory(name: self.name, clueInfos: self.clueInfos, colour: self.colour, id: self.id, orderCompleted: self.orderCompleted)
    }
}
