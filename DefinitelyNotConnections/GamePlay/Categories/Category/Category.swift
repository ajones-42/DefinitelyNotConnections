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
    let id: Int
    let orderCompleted: Int?
    var isCompleted: Bool {
        return orderCompleted != nil
    }
    
    init(name: String, clueInfos: [ClueInfo], colour: Color, id: Int, orderCompleted: Int? = nil) {
        self.name = name
        self.clueInfos = clueInfos
        self.colour = colour
        self.id = id
        self.orderCompleted = orderCompleted
    }
    
    init(id: Int, categoryInfo: CategoryInfo) {
        self.name = categoryInfo.name
        self.colour = categoryInfo.colour
        self.id = id
        self.clueInfos = categoryInfo.clueInfos
        self.orderCompleted = nil
    }
    
    func getClues() -> [String] {
        return self.clueInfos.map( {$0.clue} )
    }
    
    func getClueIDs() -> [UUID] {
        return self.clueInfos.map( {$0.id} )
    }
    
    func complete(orderCompleted: Int) -> Category {
        return Category(name: self.name, clueInfos: self.clueInfos, colour: self.colour, id: self.id, orderCompleted: orderCompleted)
    }
    
    func reset() -> Category {
        return Category(name: self.name, clueInfos: self.clueInfos, colour: self.colour, id: self.id, orderCompleted: nil)
    }
}
