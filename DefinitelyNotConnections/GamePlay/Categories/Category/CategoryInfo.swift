//
//  CategoryInfo.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 15.01.26.
//

import Foundation
import SwiftUI

struct CategoryInfo {
    let name: String
    let colour: Color
    let clues: [String]
    let clueIDs: [UUID]
    
    init(name: String, colour: Color, clues: [String], clueIDs: [UUID]) {
        self.name = name
        self.colour = colour
        self.clues = clues
        self.clueIDs = clueIDs
    }
    
    init(name: String, colour: Color, clues: [String]) {
        self.name = name
        self.colour = colour
        self.clues = clues
        self.clueIDs = self.clues.map( {_ in UUID()} )
    }
}
