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
        guard uniqueNumClues.count == 1 else {
            print("GameProperties.getNumCluesPerCategory: Number of clues must be the same for all categories.")
            throw ValidationError.invalidInput
        }
        return uniqueNumClues.first!
    }
    
    init(setupInfo: SetupInfo) {
        self.numMistakes = setupInfo.numMistakes
        self.numCategories = GameProperties.getNumCategories(categoryInfos: setupInfo.categoryInfos)
        // Crash app on failure
        try! self.numCluesPerCategory = GameProperties.getNumCluesPerCategory(categoryInfos: setupInfo.categoryInfos)
    }
    
    init(numMistakes: Int, numCategories: Int, numCluesPerCategory: Int) {
        self.numMistakes = numMistakes
        self.numCategories = numCategories
        self.numCluesPerCategory = numCluesPerCategory
    }
}
