//
//  Guesses.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 06.01.26.
//

import Foundation

@Observable
class AllGuesses {
    private(set) var guesses: [Guess]
    
    init() {
        self.guesses = []
    }
    
    init(guesses: [Guess]) {
        self.guesses = guesses
    }
    
    func reset() {
        self.guesses = []
    }

    func getGuesses() -> [Guess] {
        return self.guesses
    }
    
    func addGuess(guess: Guess) {
        self.guesses.append(guess)
    }
}
