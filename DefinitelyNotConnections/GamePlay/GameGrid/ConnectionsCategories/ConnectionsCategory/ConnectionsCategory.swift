//
//  ConnectionsCategory.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation
import SwiftUI

@Observable
class ConnectionsCategory: Identifiable {
    let name: String
    let clueInfos: [ClueInfo]
    let colour: Color
    let id: UUID
    var orderCompleted: Int?
    var isCompleted: Bool {
        return orderCompleted != nil
    }
    
    init(name: String, clueInfos: [ClueInfo], colour: Color, id: UUID, orderCompleted: Int? = nil) {
        self.name = name
        self.clueInfos = clueInfos
        self.colour = colour
        self.id = id
        self.orderCompleted = orderCompleted
    }
    
    init(connectionsCategoryInfo: ConnectionsCategoryInfo) {
        self.name = connectionsCategoryInfo.name
        self.colour = connectionsCategoryInfo.colour
        self.id = connectionsCategoryInfo.id
        self.clueInfos = connectionsCategoryInfo.clueInfos
        self.orderCompleted = nil
    }
    
    func reset() {
        self.orderCompleted = nil
    }
    
    func getClues() -> [String] {
        return self.clueInfos.map({clueInfo in
            clueInfo.getClue()
        })
    }
    
    func getClueIDs() -> [UUID] {
        return self.clueInfos.map({clueInfo in
            clueInfo.getID()
        })
    }
    
    func complete(orderCompleted: Int) {
        self.orderCompleted = orderCompleted
    }
}
