//
//  Category.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation
import SwiftUI

@Observable
class Category: Identifiable {
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
    
    init(categoryInfo: CategoryInfo) {
        self.name = categoryInfo.name
        self.colour = categoryInfo.colour
        self.id = categoryInfo.id
        self.clueInfos = categoryInfo.clueInfos
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
