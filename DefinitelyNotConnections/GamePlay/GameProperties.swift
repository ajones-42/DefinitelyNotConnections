//
//  GameProperties.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 09.01.26.
//

import Foundation

class GameProperties {
    let numMistakes: Int
    let numConnectionsCategories: Int
    let numCluesPerConnectionsCategory: Int
    
    static private func getNumConnectionsCategories(connectionsCategoryInfos: [ConnectionsCategoryInfo]) -> Int {
        return connectionsCategoryInfos.count
    }
    
    static private func getNumCluesPerConnectionsCategory(connectionsCategoryInfos: [ConnectionsCategoryInfo]) throws -> Int {
        let uniqueNumClues: Set<Int> = Set(connectionsCategoryInfos.map({connectionsCategoryInfo in
            connectionsCategoryInfo.clueInfos.count
        }))
        guard uniqueNumClues.count == 1 else {
            print("GameProperties.getNumCluesPerConnectionsCategory: Number of clues must be the same for all categories.")
            throw ValidationError.invalidInput
        }
        return uniqueNumClues.first!
    }
    
    init(setupInfo: SetupInfo) {
        self.numMistakes = setupInfo.numMistakes
        self.numConnectionsCategories = GameProperties.getNumConnectionsCategories(connectionsCategoryInfos: setupInfo.connectionsCategoryInfos)
        // Crash app on failure
        try! self.numCluesPerConnectionsCategory = GameProperties.getNumCluesPerConnectionsCategory(connectionsCategoryInfos: setupInfo.connectionsCategoryInfos)
    }
    
    init(numMistakes: Int, numConnectionsCategories: Int, numCluesPerConnectionsCategory: Int) {
        self.numMistakes = numMistakes
        self.numConnectionsCategories = numConnectionsCategories
        self.numCluesPerConnectionsCategory = numCluesPerConnectionsCategory
    }
}
