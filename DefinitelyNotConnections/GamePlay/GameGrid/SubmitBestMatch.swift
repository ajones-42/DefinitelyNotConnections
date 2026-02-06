//
//  SubmitBestMatch.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.01.26.
//

import Foundation

struct SubmitBestMatch {
    let connectionsCategoryID: UUID
    let numMatches: Int
    let isCorrect: Bool
    let isOneAway: Bool
    
    init(connectionsCategoryID: UUID, numMatches: Int, numCluesPerConnectionsCategory: Int) {
        self.connectionsCategoryID = connectionsCategoryID
        self.numMatches = numMatches
        self.isCorrect = numMatches == numCluesPerConnectionsCategory
        self.isOneAway = numMatches == numCluesPerConnectionsCategory - 1
    }
}
