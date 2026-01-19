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
    
    init(name: String, colour: Color, clueInfos: [ClueInfo]) {
        self.name = name
        self.colour = colour
        self.clueInfos = clueInfos
    }
    
    init(name: String, colour: Color, clues: [String]) {
        self.name = name
        self.colour = colour
        self.clueInfos = clues.map{clue in
                ClueInfo(clue: clue)
        }
    }
    
    func getClues() -> [String] {
        return self.clueInfos.map( {$0.clue} )
    }
    
    func getClueIDs() -> [UUID] {
        return self.clueInfos.map( {$0.id} )
    }
}
