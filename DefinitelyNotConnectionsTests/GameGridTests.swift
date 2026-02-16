//
//  GameGridTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 16.02.26.
//

import Testing
import SwiftUI
import Foundation
@testable import DefinitelyNotConnections

@Suite struct GameGridTests {
    // Reset
    @Test func testResetGameGridAllCompleted() {
        let numCluesPerConnectionsCategory: Int = 4
        let numConnectionsCategories: Int = 4
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: numCluesPerConnectionsCategory).withNumConnectionsCategories(numConnectionsCategories: numConnectionsCategories).build()
        let gameGrid: GameGrid = try! GameGridBuilder().withGameProperties(gameProperties: gameProperties).withCompleteAllConnectionsCategories().build()
        gameGrid.reset()
        #expect(gameGrid.getNumCompletedConnectionsCategories() == 0 && gameGrid.getSelectedRemainingClueBoxes().count == 0 && gameGrid.allClueBoxes.numRemainingClueBoxes == numCluesPerConnectionsCategory * numConnectionsCategories)
    }
    
    @Test func testResetGameGridNoneCompleted() {
        let numCluesPerConnectionsCategory: Int = 4
        let numConnectionsCategories: Int = 4
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: numCluesPerConnectionsCategory).withNumConnectionsCategories(numConnectionsCategories: numConnectionsCategories).build()
        let gameGrid: GameGrid = GameGridBuilder().withGameProperties(gameProperties: gameProperties).build()
        gameGrid.reset()
        #expect(gameGrid.getNumCompletedConnectionsCategories() == 0 && gameGrid.getSelectedRemainingClueBoxes().count == 0 && gameGrid.allClueBoxes.numRemainingClueBoxes == numCluesPerConnectionsCategory * numConnectionsCategories)
    }
    
    @Test func testResetGameGridSomeCompleted() {
        let numCluesPerConnectionsCategory: Int = 4
        let numConnectionsCategories: Int = 4
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: numCluesPerConnectionsCategory).withNumConnectionsCategories(numConnectionsCategories: numConnectionsCategories).build()
        let gameGrid: GameGrid = try! GameGridBuilder().withGameProperties(gameProperties: gameProperties).withNCompletedConnectionsCategories(n: 2).build()
        gameGrid.reset()
        #expect(gameGrid.getNumCompletedConnectionsCategories() == 0 && gameGrid.getSelectedRemainingClueBoxes().count == 0 && gameGrid.allClueBoxes.numRemainingClueBoxes == numCluesPerConnectionsCategory * numConnectionsCategories)
    }

    // Complete Connections Category
    @Test func testCompleteConnectionsCategory() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = try! createTestConnectionsCategoryInfos(numConnectionsCategories: 2, colours: [.black, .blue], numCluesPerConnectionsCategory: 4)
        let connectionsCategoryID1: UUID = try! #require(connectionsCategoryInfos.first?.id)
        let connectionsCategoryID2: UUID = try! #require(connectionsCategoryInfos.last?.id)
        let setupInfo: SetupInfo = SetupInfo(connectionsCategoryInfos: connectionsCategoryInfos, numMistakes: 4)
        let gameGrid: GameGrid = try! GameGridBuilder(setupInfo: setupInfo).withSelectAllClueBoxes().build()
        try! gameGrid.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryID1)
        #expect(gameGrid.getNumCompletedConnectionsCategories() == 1 && gameGrid.allClueBoxes.numRemainingClueBoxes == 4)
        #expect(gameGrid.getSelectedRemainingClueBoxes().allSatisfy({$0.getConnectionsCategoryID() == connectionsCategoryID2}))
    }

    @Test func testCompleteConnectionsCategoryAlreadyCompleted() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = try! createTestConnectionsCategoryInfos(numConnectionsCategories: 2, colours: [.black, .blue], numCluesPerConnectionsCategory: 4)
        let connectionsCategoryID1: UUID = try! #require(connectionsCategoryInfos.first?.id)
        let connectionsCategoryID2: UUID = try! #require(connectionsCategoryInfos.last?.id)
        let setupInfo: SetupInfo = SetupInfo(connectionsCategoryInfos: connectionsCategoryInfos, numMistakes: 4)
        let gameGrid: GameGrid = try! GameGridBuilder(setupInfo: setupInfo).withSelectAllClueBoxes().build()
        try! gameGrid.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryID1)
        #expect(throws: ValidationError.alreadyCompletedConnectionsCategory) {
            try gameGrid.completeConnectionsCategory(connectionsCategoryID: connectionsCategoryID1)
        }
        #expect(gameGrid.getNumCompletedConnectionsCategories() == 1 && gameGrid.allClueBoxes.numRemainingClueBoxes == 4)
        #expect(gameGrid.getSelectedRemainingClueBoxes().allSatisfy({$0.getConnectionsCategoryID() == connectionsCategoryID2}))
    }
    
    @Test func testCompleteUnknownConnectionsCategory() {
        let connectionsCategoryInfos: [ConnectionsCategoryInfo] = try! createTestConnectionsCategoryInfos(numConnectionsCategories: 2, colours: [.black, .blue], numCluesPerConnectionsCategory: 4)
        let connectionsCategoryID1: UUID = try! #require(connectionsCategoryInfos.first?.id)
        let connectionsCategoryID2: UUID = try! #require(connectionsCategoryInfos.last?.id)
        let setupInfo: SetupInfo = SetupInfo(connectionsCategoryInfos: connectionsCategoryInfos, numMistakes: 4)
        let gameGrid: GameGrid = try! GameGridBuilder(setupInfo: setupInfo).withSelectAllClueBoxes().build()
        #expect(throws: ValidationError.unknownConnectionsCategoryID) {
            try gameGrid.completeConnectionsCategory(connectionsCategoryID: UUID())
        }
        #expect(gameGrid.getNumCompletedConnectionsCategories() == 0 && gameGrid.allClueBoxes.numRemainingClueBoxes == 8)
        #expect(gameGrid.getSelectedRemainingClueBoxes().allSatisfy({$0.getConnectionsCategoryID() == connectionsCategoryID1 || $0.getConnectionsCategoryID() == connectionsCategoryID2}))
    }

}
