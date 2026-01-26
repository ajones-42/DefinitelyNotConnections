//
//  AllGuessesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class AllGuessesBuilder {
    var guesses: [Guess] = [GuessBuilder().build()]
    
    func withGuesses(guesses: [Guess]) -> AllGuessesBuilder {
        self.guesses = guesses
        return self
    }
    
    func build() -> AllGuesses {
        return AllGuesses(guesses: self.guesses)
    }
}
