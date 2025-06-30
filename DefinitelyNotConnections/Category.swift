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
    
    init(name: String, boxTexts: [String], colour: Color, id: Int) {
        self.name = name
        self.clueBoxes = Category.createClueBoxes(boxTexts: boxTexts, offset: id)
        self.colour = colour
        self.id = id
    }
    
    static func createClueBoxes(boxTexts: [String], offset: Int) -> [ClueBox] {
        var tmpClueBoxes: [ClueBox] = []
        for (i, boxText) in boxTexts.enumerated() {
            tmpClueBoxes.append(ClueBox(text: boxText, id: i+4*offset))
        }
        return tmpClueBoxes
    }
}
