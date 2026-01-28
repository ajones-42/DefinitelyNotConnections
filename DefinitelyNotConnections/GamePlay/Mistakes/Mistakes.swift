//
//  Mistakes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 08.01.26.
//

import Foundation

@Observable
class Mistakes {
    var numMistakesRemaining: Int
    let gameProperties: GameProperties
    var outOfMistakes: Bool {
        self.numMistakesRemaining == 0
    }
    
    init(gameProperties: GameProperties) {
        self.gameProperties = gameProperties
        self.numMistakesRemaining = self.gameProperties.numMistakes
    }
    
    init(numMistakesRemaining: Int, gameProperties: GameProperties) {
        self.numMistakesRemaining = numMistakesRemaining
        self.gameProperties = gameProperties
    }
    
    func reset() {
        self.numMistakesRemaining = self.gameProperties.numMistakes
    }
    
    func madeMistake() {
        return self.numMistakesRemaining -= 1
    }
    
    func getOriginalNumMistakes() -> Int {
        return self.gameProperties.numMistakes
    }
}
