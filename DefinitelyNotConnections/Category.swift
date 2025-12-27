//
//  Category.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation
import SwiftUI


class Category: Identifiable {
    let name: String
    var clueBoxes: [ClueBox]
    let colour: Color
    let id: Int
    
    init(name: String, clueBoxTexts: [String], colour: Color, id: Int) {
        self.name = name
        self.clueBoxes = Category.createClueBoxes(clueBoxTexts: clueBoxTexts, offset: id)
        self.colour = colour
        self.id = id
    }
    
    init(name: String, clueBoxes: [ClueBox], colour: Color, id: Int) {
        self.name = name
        self.clueBoxes = clueBoxes
        self.colour = colour
        self.id = id
    }
    
    static func createClueBoxes(clueBoxTexts: [String], offset: Int) -> [ClueBox] {
        var tmpClueBoxes: [ClueBox] = []
        for (i, boxText) in clueBoxTexts.enumerated() {
            tmpClueBoxes.append(ClueBox(text: boxText, id: i+4*offset))
        }
        return tmpClueBoxes
    }
}
