//
//  AllGuessesTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 04.02.26.
//

import Testing
@testable import DefinitelyNotConnections

@Suite struct AllGuessesTests {
    // Reset
    @Test func testReset() {
        let allGuesses: AllGuesses = AllGuessesBuilder().withGuesses(guesses: [GuessBuilder().build()]).build()
        allGuesses.reset()

        #expect(allGuesses.guesses.isEmpty)
    }
    
    @Test func testResetEmpty() {
        let allGuesses: AllGuesses = AllGuessesBuilder().withGuesses(guesses: []).build()
        allGuesses.reset()

        #expect(allGuesses.guesses.isEmpty)
    }
    
    // Add guess
    @Test func testAddGuessToEmptyGuesses() {
        let allGuesses: AllGuesses = AllGuessesBuilder().withGuesses(guesses: []).build()
        let newGuess: Guess = GuessBuilder().build()
        try! allGuesses.addGuess(guess: newGuess)

        #expect(allGuesses.guesses.count == 1 && allGuesses.guesses.last == newGuess)
    }

    @Test func testAddGuess() {
        let allGuesses: AllGuesses = AllGuessesBuilder().withGuesses(guesses: [GuessBuilder().build()]).build()
        let newGuess: Guess = GuessBuilder().build()
        try! allGuesses.addGuess(guess: newGuess)

        #expect(allGuesses.guesses.count == 2 && allGuesses.guesses.last == newGuess)
    }
}
