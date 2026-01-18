//
//  GameProperties.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 09.01.26.
//

import Foundation

struct GameProperties {
    let numMistakes: Int
    
    init(numMistakes: Int) {
        self.numMistakes = numMistakes
    }
    
    init() {
        self.init(numMistakes: 4)
    }
}
