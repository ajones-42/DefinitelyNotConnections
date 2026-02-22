//
//  GuessTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 03.02.26.
//

import Testing
import Foundation
@testable import DefinitelyNotConnections

@Suite struct GuessTests {
    
    // Gueses match ClueInfos
    @Test func testGuessContainsSameCluesAs() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfos: [ClueInfo] = [clueInfo1, clueInfo2]
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: clueInfos).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: clueInfos).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == true)
    }

    @Test func testGuessContainsSameCluesAsDifferentOrder() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2]).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo2, clueInfo1]).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == true)
    }
    
    @Test func testGuessContainsSameCluesAsWithDuplicateClue() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2]).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2, clueInfo2]).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == true)
    }
    
    @Test func testGuessContainsNoSameClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2]).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo3, clueInfo4]).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == false)
    }
    
    @Test func testGuessContainsSomeSameClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2]).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo2, clueInfo3]).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == false)
    }
    
    @Test func testGuessContainsDifferentNumbersOfClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2]).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo3]).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == false)
    }
    
    @Test func testGuessContainsDifferentNumbersOfCluesReversed() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1]).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo2, clueInfo3]).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == false)
    }
    
    @Test func testGuessContainsDifferentNumbersOfCluesSomeOverlap() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2, clueInfo3]).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo3, clueInfo4]).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == false)
    }
    
    @Test func testGuessContainsDifferentNumbersOfCluesSomeOverlapReversed() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let guess1: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo1, clueInfo2]).build()
        let guess2: Guess = GuessBuilder().withClueInfos(clueInfos: [clueInfo2, clueInfo3, clueInfo4]).build()
        #expect(guess1.containsSameCluesAs(guess: guess2) == false)
    }
    
    // Guess (doesn't) match(es) clueBoxes

    @Test func testGuessMatchesClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let clueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: clueInfos).build()

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: clueInfos.map({$0.getID()})) == true)
    }
    
    @Test func testGuessMatchesNoClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let clueInfo5: ClueInfo = ClueInfo(clue: "Clue5", connectionsCategoryID: UUID())
        let clueInfo6: ClueInfo = ClueInfo(clue: "Clue6", connectionsCategoryID: UUID())
        let clueInfo7: ClueInfo = ClueInfo(clue: "Clue7", connectionsCategoryID: UUID())
        let clueInfo8: ClueInfo = ClueInfo(clue: "Clue8", connectionsCategoryID: UUID())
        let guessClueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: guessClueInfos).build()
        let otherClueInfoIDs: [UUID] = [clueInfo5, clueInfo6, clueInfo7, clueInfo8].map({$0.getID()})

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: otherClueInfoIDs) == false)
    }
    
    @Test func testGuessMatchesSomeClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let clueInfo7: ClueInfo = ClueInfo(clue: "Clue7", connectionsCategoryID: UUID())
        let clueInfo8: ClueInfo = ClueInfo(clue: "Clue8", connectionsCategoryID: UUID())
        let guessClueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: guessClueInfos).build()
        let otherClueInfoIDs: [UUID] = [clueInfo3, clueInfo4, clueInfo7, clueInfo8].map({$0.getID()})

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: otherClueInfoIDs) == false)
    }

    @Test func testGuessHasMoreClueBoxes() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let clueInfo5: ClueInfo = ClueInfo(clue: "Clue5", connectionsCategoryID: UUID())
        let guessClueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4, clueInfo5]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: guessClueInfos).build()
        let otherClueInfoIDs: [UUID] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4].map({$0.getID()})

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: otherClueInfoIDs) == false)
    }
    
    @Test func testGuessHasFewerClueBoxes() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", connectionsCategoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", connectionsCategoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", connectionsCategoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", connectionsCategoryID: UUID())
        let guessClueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: guessClueInfos).build()
        let otherClueInfoIDs: [UUID] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4].map({$0.getID()})

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: otherClueInfoIDs) == false)
    }
    
    // Equatability
    @Test func testDifferentGuessesNotEquated() {
        let guess1: Guess = GuessBuilder().build()
        let guess2: Guess = GuessBuilder().build()

        #expect(guess1 != guess2)
    }
}
