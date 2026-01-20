//
//  GameProperties.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 09.01.26.
//

import Foundation

struct GameProperties {
    let numMistakes: Int
    let numCluesPerCategory: Int
    
    init(numMistakes: Int, numCluesPerCategory: Int) {
        self.numMistakes = numMistakes
        self.numCluesPerCategory = numCluesPerCategory
    }
    
    init() {
        self.init(numMistakes: 4, numCluesPerCategory: 4)
    }
}
