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
    let clues: [String]
    let colour: Color
    let id: Int
    let orderCompleted: Int?
    var isCompleted: Bool {
        return orderCompleted != nil
    }
    
    init(name: String, clues: [String], colour: Color, id: Int, orderCompleted: Int? = nil) {
        self.name = name
        self.clues = clues
        self.colour = colour
        self.id = id
        self.orderCompleted = orderCompleted
    }
    
    init(id: Int, categoryInfo: CategoryInfo) {
        self.name = categoryInfo.name
        self.colour = categoryInfo.colour
        self.id = id
        self.clues = categoryInfo.clues
        self.orderCompleted = nil
    }
    
    func complete(orderCompleted: Int) -> Category {
        return Category(name: self.name, clues: self.clues, colour: self.colour, id: self.id, orderCompleted: orderCompleted)
    }
    
    func reset() -> Category {
        return Category(name: self.name, clues: self.clues, colour: self.colour, id: self.id, orderCompleted: nil)
    }
}
