//
//  Mistakes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 08.01.26.
//

import Foundation


@Observable
class Mistakes {
    var initialNumMistakesRemaining: Int
    var numMistakesRemaining: Int
    var noMistakesLeft: Bool {
        self.numMistakesRemaining == 0
    }
    
    init(initialNumMistakesRemaining: Int = 4) {
        self.initialNumMistakesRemaining = initialNumMistakesRemaining
        self.numMistakesRemaining = initialNumMistakesRemaining
    }
    
    func reset() {
        self.numMistakesRemaining = self.initialNumMistakesRemaining
    }
    
    func getNumMistakesRemaining() -> Int {
        return self.numMistakesRemaining
    }
    
    func madeMistake() {
        self.numMistakesRemaining -= 1
    }
}
