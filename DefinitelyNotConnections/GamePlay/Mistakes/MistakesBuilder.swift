//
//  MistakesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class MistakesBuilder {
    var numMistakesRemaining: Int = 4
    var gameProperties: GameProperties = GamePropertiesBuilder().build()
    
    func withnumMistakesRemaining(numMistakesRemaining: Int) -> MistakesBuilder {
        self.numMistakesRemaining = numMistakesRemaining
        return self
    }
    
    func withGameProperties(gameProperties: GameProperties) -> MistakesBuilder {
        self.gameProperties = gameProperties
        return self
    }
    
    func build() -> Mistakes {
        return Mistakes(numMistakesRemaining: self.numMistakesRemaining, gameProperties: self.gameProperties)
    }
}
