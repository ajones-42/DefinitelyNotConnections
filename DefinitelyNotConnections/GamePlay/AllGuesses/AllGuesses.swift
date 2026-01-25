//
//  Guesses.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 06.01.26.
//

import Foundation

struct AllGuesses {
    let guesses: [Guess]
    
    init() {
        self.guesses = []
    }
    
    init(guesses: [Guess]) {
        self.guesses = guesses
    }
    
    func reset() -> AllGuesses {
        return AllGuesses(guesses: [])
    }

    func getGuesses() -> [Guess] {
        return self.guesses
    }
    
    func addGuess(guess: Guess) -> AllGuesses {
        let newGuesses: [Guess] = self.guesses + [guess]
        return AllGuesses(guesses: newGuesses)
    }
    
    func selectionAlreadyGuessed(selectedClueBoxIDs: [UUID]) -> Bool {
        return getGuesses().map({guess in
            guess.clueBoxesMatchGuess(clueBoxIDs: selectedClueBoxIDs)
        }).contains(true)
    }
}
