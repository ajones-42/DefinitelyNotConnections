//
//  AllGuessesTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 04.02.26.
//

import Testing
@testable import DefinitelyNotConnections

@Suite struct AllGuessesTests {
    let emptyGuessesAllGuesses: AllGuesses = AllGuessesBuilder().withGuesses(guesses: []).build()
    let allGuessesWithGuess: AllGuesses = AllGuessesBuilder().withGuesses(guesses: [GuessBuilder().build()]).build()
    
    @Test func testReset() {
        let allGuesses: AllGuesses = allGuessesWithGuess
        allGuesses.reset()
        #expect(allGuesses.guesses.isEmpty)
    }
    
    @Test func testResetEmpty() {
        let allGuesses: AllGuesses = emptyGuessesAllGuesses
        allGuesses.reset()
        #expect(allGuesses.guesses.isEmpty)
    }
    
    @Test func testAddGuessToEmptyGuesses() {
        let allGuesses: AllGuesses = emptyGuessesAllGuesses
        let newGuess: Guess = GuessBuilder().build()
        allGuesses.addGuess(guess: newGuess)
        #expect(allGuesses.guesses.count == 1 && allGuesses.guesses.last == newGuess)
    }

    @Test func testAddGuess() {
        let allGuesses: AllGuesses = allGuessesWithGuess
        let newGuess: Guess = GuessBuilder().build()
        allGuesses.addGuess(guess: newGuess)
        #expect(allGuesses.guesses.count == 2 && allGuesses.guesses.last == newGuess)
    }
}
