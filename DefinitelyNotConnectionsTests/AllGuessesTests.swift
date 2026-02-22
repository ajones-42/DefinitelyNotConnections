//
//  AllGuessesTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 04.02.26.
//

import Testing
import Foundation
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

    @Test func testAddNewGuess() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let allGuesses: AllGuesses = AllGuessesBuilder().withGuesses(guesses: [GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2]).build()]).build()
        let newGuess: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo3, clueInfo4]).build()
        try! allGuesses.addGuess(guess: newGuess)

        #expect(allGuesses.guesses.count == 2 && allGuesses.guesses.last == newGuess)
    }
    
    @Test func testAddSameGuess() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfos: [ClueInfo] = [clueInfo1, clueInfo2]
        let oldGuess: Guess = GuessBuilder().withClueInfos(clueInfos: clueInfos).build()
        let allGuesses: AllGuesses = AllGuessesBuilder().withGuesses(guesses: [oldGuess]).build()
        let newGuess: Guess = GuessBuilder().withClueInfos(clueInfos: clueInfos).build()
        #expect(throws: ValidationError.alreadyGuessed) {
            try allGuesses.addGuess(guess: newGuess)
        }

        #expect(allGuesses.guesses.count == 1 && allGuesses.guesses.last == oldGuess)
    }
}
