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
    let connectionsCategoryID: UUID
    
    init(clue: String, connectionsCategoryID: UUID) {
        self.clue = clue
        self.id = UUID()
        self.connectionsCategoryID = connectionsCategoryID
    }
    
    func getID() -> UUID {
        return self.id
    }
    
    func getClue() -> String {
        return self.clue
    }
    
    func getConnectionsCategoryID() -> UUID {
        return self.connectionsCategoryID
    }
}
