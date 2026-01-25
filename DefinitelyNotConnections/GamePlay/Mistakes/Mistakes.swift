//
//  Mistakes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 08.01.26.
//

import Foundation


struct Mistakes {
    let numMistakesRemaining: Int
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
    
    private func recompute(numMistakesRemaining: Int) -> Mistakes {
        return Mistakes(numMistakesRemaining: numMistakesRemaining, gameProperties: self.gameProperties)
    }
    
    func madeMistake() -> Mistakes {
        return recompute(numMistakesRemaining: self.numMistakesRemaining - 1)
    }
}
