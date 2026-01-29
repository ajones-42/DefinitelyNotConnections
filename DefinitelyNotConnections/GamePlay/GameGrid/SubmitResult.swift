//
//  SubmitResult.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 16.01.26.
//

import Foundation

struct SubmitResult {
    let categoryID: UUID
    let numMatches: Int
    let isCorrect: Bool
    let isOneAway: Bool
    
    init(categoryID: UUID, numMatches: Int, numCluesPerCategory: Int) {
        self.categoryID = categoryID
        self.numMatches = numMatches
        self.isCorrect = numMatches == numCluesPerCategory
        self.isOneAway = numMatches == numCluesPerCategory - 1
    }
}
