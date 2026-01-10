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
    let clueBoxes: [ClueBox]
    let colour: Color
    let id: Int
    let orderCompleted: Int?
    
    init(name: String, clueBoxTexts: [String], colour: Color, id: Int, orderCompleted: Int? = nil) {
        self.name = name
        // TODO remove this?
        self.clueBoxes = Category.createClueBoxes(clueBoxTexts: clueBoxTexts, offset: id)
        self.colour = colour
        self.id = id
        self.orderCompleted = orderCompleted
    }
    
    init(name: String, clueBoxes: [ClueBox], colour: Color, id: Int, orderCompleted: Int? = nil) {
        self.name = name
        self.clueBoxes = clueBoxes
        self.colour = colour
        self.id = id
        self.orderCompleted = orderCompleted
    }
    
    static func createClueBoxes(clueBoxTexts: [String], offset: Int) -> [ClueBox] {
        var tmpClueBoxes: [ClueBox] = []
        for (i, boxText) in clueBoxTexts.enumerated() {
            tmpClueBoxes.append(ClueBox(text: boxText, id: i+4*offset))
        }
        return tmpClueBoxes
    }
}
