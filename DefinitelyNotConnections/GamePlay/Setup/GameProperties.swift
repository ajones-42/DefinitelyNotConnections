//
//  GameProperties.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 09.01.26.
//

import Foundation

class GameProperties {
    let numMistakes: Int
    let numCategories: Int
    let numCluesPerCategory: Int
    
    static private func getNumCategories(categoryInfos: [CategoryInfo]) -> Int {
        return categoryInfos.count
    }
    
    static private func getNumCluesPerCategory(categoryInfos: [CategoryInfo]) throws -> Int {
        let uniqueNumClues: Set<Int> = Set(categoryInfos.map({categoryInfo in
            categoryInfo.clueInfos.count
        }))
        if uniqueNumClues.count == 1 {
            return uniqueNumClues.first!
        } else {
            print("GameProperties.getNumCluesPerCategory: Number of clues must be the same for all categories.")
            throw ValidationError.invalidInput
        }
    }
    
    init(numMistakes: Int, setupInfo: SetupInfo) {
        self.numMistakes = numMistakes
        self.numCategories = GameProperties.getNumCategories(categoryInfos: setupInfo.categoryInfos)
        // Crash app on failure
        try! self.numCluesPerCategory = GameProperties.getNumCluesPerCategory(categoryInfos: setupInfo.categoryInfos)
    }
}
