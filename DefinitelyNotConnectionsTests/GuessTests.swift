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
    let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", categoryID: UUID())
    let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", categoryID: UUID())
    let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", categoryID: UUID())
    let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", categoryID: UUID())
    let clueInfo5: ClueInfo = ClueInfo(clue: "Clue5", categoryID: UUID())
    let clueInfo6: ClueInfo = ClueInfo(clue: "Clue6", categoryID: UUID())
    let clueInfo7: ClueInfo = ClueInfo(clue: "Clue7", categoryID: UUID())
    let clueInfo8: ClueInfo = ClueInfo(clue: "Clue8", categoryID: UUID())
    
    // Guess (doesn't) match(es) clueBoxes

    @Test func testGuessMatchesClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", categoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", categoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", categoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", categoryID: UUID())
        let clueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: clueInfos).build()

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: clueInfos.map({$0.getID()})) == true)
    }
    
    @Test func testGuessMatchesNoClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", categoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", categoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", categoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", categoryID: UUID())
        let clueInfo5: ClueInfo = ClueInfo(clue: "Clue5", categoryID: UUID())
        let clueInfo6: ClueInfo = ClueInfo(clue: "Clue6", categoryID: UUID())
        let clueInfo7: ClueInfo = ClueInfo(clue: "Clue7", categoryID: UUID())
        let clueInfo8: ClueInfo = ClueInfo(clue: "Clue8", categoryID: UUID())
        let guessClueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: guessClueInfos).build()
        let otherClueInfoIDs: [UUID] = [clueInfo5, clueInfo6, clueInfo7, clueInfo8].map({$0.getID()})

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: otherClueInfoIDs) == false)
    }
    
    @Test func testGuessMatchesSomeClues() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", categoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", categoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", categoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", categoryID: UUID())
        let clueInfo7: ClueInfo = ClueInfo(clue: "Clue7", categoryID: UUID())
        let clueInfo8: ClueInfo = ClueInfo(clue: "Clue8", categoryID: UUID())
        let guessClueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: guessClueInfos).build()
        let otherClueInfoIDs: [UUID] = [clueInfo3, clueInfo4, clueInfo7, clueInfo8].map({$0.getID()})

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: otherClueInfoIDs) == false)
    }

    @Test func testGuessHasMoreClueBoxes() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", categoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", categoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", categoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", categoryID: UUID())
        let clueInfo5: ClueInfo = ClueInfo(clue: "Clue5", categoryID: UUID())
        let guessClueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4, clueInfo5]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: guessClueInfos).build()
        let otherClueInfoIDs: [UUID] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4].map({$0.getID()})

        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: otherClueInfoIDs) == false)
    }
    
    @Test func testGuessHasFewerClueBoxes() {
        let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", categoryID: UUID())
        let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", categoryID: UUID())
        let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", categoryID: UUID())
        let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", categoryID: UUID())
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
