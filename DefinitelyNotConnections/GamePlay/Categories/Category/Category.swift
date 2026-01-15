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
    //let clueBoxes: [ClueBox]
    let colour: Color
    let id: Int
    let orderCompleted: Int?
    var isCompleted: Bool {
        return orderCompleted != nil
    }
    
    init(name: String, clues: [String], colour: Color, id: Int, orderCompleted: Int? = nil) {
        self.name = name
        // TODO remove this?
        //self.clueBoxes = Category.createClueBoxes(clueBoxTexts: clueBoxTexts, offset: id)
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
        //self.clueBoxes = Category.createClueBoxes(clueBoxTexts: categoryInfo.clues, offset: id)
        self.orderCompleted = nil
    }
    
    /*init(name: String, clueBoxes: [ClueBox], colour: Color, id: Int, orderCompleted: Int? = nil) {
        self.name = name
        self.clueBoxes = clueBoxes
        self.colour = colour
        self.id = id
        self.orderCompleted = orderCompleted
    }*/
    
    /*static func createClueBoxes(clueBoxTexts: [String], offset: Int) -> [ClueBox] {
        var tmpClueBoxes: [ClueBox] = []
        for (i, boxText) in clueBoxTexts.enumerated() {
            tmpClueBoxes.append(ClueBox(text: boxText, id: i+4*offset))
        }
        return tmpClueBoxes
    }*/
    
    func complete(orderCompleted: Int) -> Category {
        return Category(name: self.name, clues: self.clues, colour: self.colour, id: self.id, orderCompleted: orderCompleted)
    }
    
    func reset() -> Category {
        return Category(name: self.name, clues: self.clues, colour: self.colour, id: self.id, orderCompleted: nil)
    }
    
    /*func complete(orderCompleted: Int) -> Category {
        return Category(name: self.name, clueBoxes: self.clueBoxes, colour: self.colour, id: self.id, orderCompleted: orderCompleted)
    }
    
    func reset() -> Category {
        return Category(name: self.name, clueBoxes: self.clueBoxes, colour: self.colour, id: self.id, orderCompleted: nil)
    }*/
}
