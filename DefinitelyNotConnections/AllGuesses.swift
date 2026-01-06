//
//  Guesses.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 06.01.26.
//

import Foundation

@Observable
class AllGuesses {
    var guesses: [Guess]
    
    init() {
        self.guesses = []
    }

    func getGuesses() -> [Guess] {
        return self.guesses
    }
    
    func getNextGuessID() -> Int {
        return self.guesses.count
    }
    
    func addGuess(guess: Guess) {
        self.guesses.append(guess)
    }
    
    func selectionAlreadyGuessed(selectedBoxIDs: [Int]) -> Bool {
        var selectionAlreadyGuessed: Bool = false
        for guess in self.getGuesses() {
            if getClueBoxIDs(clueBoxes: guess.clueBoxes).sorted() == selectedBoxIDs.sorted() {
                selectionAlreadyGuessed = true
                break
            }
        }
        return selectionAlreadyGuessed
    }
}
