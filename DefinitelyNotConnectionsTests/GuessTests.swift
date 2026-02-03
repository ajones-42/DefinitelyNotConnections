//
//  GuessTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 03.02.26.
//

import Testing
import Foundation
@testable import DefinitelyNotConnections

struct GuessTests {
    let clueInfo1: ClueInfo = ClueInfo(clue: "Clue1", categoryID: UUID())
    let clueInfo2: ClueInfo = ClueInfo(clue: "Clue2", categoryID: UUID())
    let clueInfo3: ClueInfo = ClueInfo(clue: "Clue3", categoryID: UUID())
    let clueInfo4: ClueInfo = ClueInfo(clue: "Clue4", categoryID: UUID())
    let clueInfo5: ClueInfo = ClueInfo(clue: "Clue5", categoryID: UUID())
    let clueInfo6: ClueInfo = ClueInfo(clue: "Clue6", categoryID: UUID())
    let clueInfo7: ClueInfo = ClueInfo(clue: "Clue7", categoryID: UUID())
    let clueInfo8: ClueInfo = ClueInfo(clue: "Clue8", categoryID: UUID())

    @Test func guessMatchesClues()  {
        let clueInfos: [ClueInfo] = [clueInfo1, clueInfo2, clueInfo3, clueInfo4]
        let guess: Guess = GuessBuilder().withClueInfos(clueInfos: clueInfos).build()
        #expect(guess.clueBoxesMatchGuess(clueBoxIDs: clueInfos.map({$0.getID()})))
    }

}
