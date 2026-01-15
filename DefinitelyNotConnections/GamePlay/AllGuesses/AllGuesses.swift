//
//  Guesses.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 06.01.26.
//

import Foundation

struct AllGuesses {
    let guesses: [Guess]
    
    func reset() -> AllGuesses {
        return AllGuesses(guesses: [])
    }

    func getGuesses() -> [Guess] {
        return self.guesses
    }
    
    func getNextGuessID() -> Int {
        return self.guesses.count
    }
    
    func addGuess(guess: Guess) -> AllGuesses {
        var newGuesses: [Guess] = self.guesses
        newGuesses.append(guess)
        return AllGuesses(guesses: newGuesses)
    }
    
    func selectionAlreadyGuessed(selectedBoxClues: [String]) -> Bool {
        var selectionAlreadyGuessed: Bool = false
        for guess in self.getGuesses() {
            //if getClueBoxIDs(clueBoxes: guess.clueBoxes).sorted() == selectedBoxIDs.sorted() {
            if guess.clues.sorted() == selectedBoxClues.sorted() {
                selectionAlreadyGuessed = true
                break
            }
        }
        return selectionAlreadyGuessed
    }
}
