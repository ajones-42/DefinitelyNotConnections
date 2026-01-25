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
    init(numMistakes: Int, setupInfo: SetupInfo) {
        self.numMistakes = numMistakes
        self.numCategories = GameProperties.getNumCategories(categoryInfos: setupInfo.categoryInfos)
        // Crash app on failure
        try! self.numCluesPerCategory = setupInfo.getNumCluesPerCategory()
    }
}
