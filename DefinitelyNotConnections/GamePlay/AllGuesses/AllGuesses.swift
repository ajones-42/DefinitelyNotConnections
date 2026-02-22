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
    
    func notAlreadyGuessed(newGuess: Guess) -> Bool {
        self.guesses.allSatisfy({ guess in
            !guess.containsSameCluesAs(guess: newGuess)
        })
    }
    
    func addGuess(guess: Guess) throws {
        if notAlreadyGuessed(newGuess: guess) {
            self.guesses.append(guess)
        } else {
            throw ValidationError.alreadyGuessed
        }
    }
}
