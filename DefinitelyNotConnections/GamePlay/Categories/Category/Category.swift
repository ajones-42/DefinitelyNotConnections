//
//  Category.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation
import SwiftUI

struct Category: Identifiable {
    let name: String
    let clueInfos: [ClueInfo]
    let colour: Color
    let id: UUID
    let orderCompleted: Int?
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
    
    init(id: Int, categoryInfo: CategoryInfo) {
        self.name = categoryInfo.name
        self.colour = categoryInfo.colour
        self.id = categoryInfo.id
        self.clueInfos = categoryInfo.clueInfos
        self.orderCompleted = nil
    }
    
    private func recompute(orderCompleted: Int?) -> Category {
        return Category(name: self.name, clueInfos: self.clueInfos, colour: self.colour, id: self.id, orderCompleted: orderCompleted)
    }
    
    func getClues() -> [String] {
        return self.clueInfos.map({clueInfo in
            clueInfo.clue
        })
    }
    
    func getClueIDs() -> [UUID] {
        return self.clueInfos.map({clueInfo in
            clueInfo.id
        })
    }
    
    func complete(orderCompleted: Int) -> Category {
        return recompute(orderCompleted: orderCompleted)
    }
    
    func reset() -> Category {
        return recompute(orderCompleted: nil)
    }
}
