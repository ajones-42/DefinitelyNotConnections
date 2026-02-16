//
//  Mistakes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 08.01.26.
//

import Foundation

@Observable
class Mistakes {
    private(set) var numMistakesRemaining: Int
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
    
    func setToZeroMistakesRemaining() {
        self.numMistakesRemaining = 0
    }
    
    func madeMistake() throws {
        guard self.numMistakesRemaining >= 1 else {
            print("Mistakes.madeMistake: Already at \(self.numMistakesRemaining) mistakes remaining. Can't go below 0.")
            throw ValidationError.invalidNumMistakesRemaining
        }
        self.numMistakesRemaining -= 1
    }
    
    func getOriginalNumMistakes() -> Int {
        return self.gameProperties.numMistakes
    }
}
