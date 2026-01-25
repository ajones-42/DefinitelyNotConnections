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
    
    init(numMistakes: Int, setupInfo: SetupInfo) {
        self.numMistakes = numMistakes
        self.numCategories = setupInfo.getNumCategories()
        self.numCluesPerCategory = setupInfo.numCluesPerCategory
    }
}
