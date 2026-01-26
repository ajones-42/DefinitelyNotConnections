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
    let clueInfos: [ClueInfo]
    let id: UUID
    
    init(name: String, colour: Color, clues: [String]) {
        self.name = name
        self.colour = colour
        self.clueInfos = createClueInfos(clues: clues)
        self.id = UUID()
    }
}
