//
//  CategoryBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation
import SwiftUI

class CategoryBuilder {
    var name: String = "A Category"
    var clueInfos: [ClueInfo] = []
    var colour: Color = .red
    var id: UUID = UUID()
    var orderCompleted: Int? = nil

    func withName(name: String) -> CategoryBuilder {
        self.name = name
        return self
    }
    
    func withClueInfos(clueInfos: [ClueInfo]) -> CategoryBuilder {
        self.clueInfos = clueInfos
        return self
    }
    
    func withColour(colour: Color) -> CategoryBuilder {
        self.colour = colour
        return self
    }
    
    func withID(id: UUID) -> CategoryBuilder {
        self.id = id
        return self
    }
    
    func withOrderCompleted(orderCompleted: Int?) -> CategoryBuilder {
        self.orderCompleted = orderCompleted
        return self
    }
    
    func build() -> Category {
        return Category(name: self.name, clueInfos: self.clueInfos, colour: self.colour, id: self.id, orderCompleted: self.orderCompleted)
    }
}
