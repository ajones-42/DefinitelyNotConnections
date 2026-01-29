//
//  ClueInfo.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 17.01.26.
//

import Foundation

struct ClueInfo: Equatable {
    let clue: String
    let id: UUID
    let categoryID: UUID
    
    init(clue: String, categoryID: UUID) {
        self.clue = clue
        self.id = UUID()
        self.categoryID = categoryID
    }
}
