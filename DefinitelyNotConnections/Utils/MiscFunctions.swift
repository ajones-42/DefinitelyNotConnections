//
//  MiscFunctions.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 23.06.25.
//

import Foundation
import SwiftUI

func concatClues(clues: [String]) -> String {
    return clues.joined(separator: ", ")
}

func getNumSameElementsInArrays<T: Equatable>(lhs: [T], rhs: [T]) -> Int {
    // If I ever expect one array to be much larger than the other, it may be worth finding and probing with the larger array
    return lhs.map({lhElement in
        rhs.contains(lhElement) ? 1 : 0}).reduce(0, {x, y in
        x + y
    })
}

func createDefaultClues(numCluesPerConnectionsCategory: Int, connectionsCategoryNumber: Int) -> [String] {
    var clues: [String] = []
    for clueNumber in 0...numCluesPerConnectionsCategory - 1 {
        clues.append("Clue \(numCluesPerConnectionsCategory * connectionsCategoryNumber + clueNumber)")
    }
    return clues
}

func createTestConnectionsCategoryInfos(numConnectionsCategories: Int, colours: [Color], numCluesPerConnectionsCategory: Int) throws -> [ConnectionsCategoryInfo] {
    guard colours.count == numConnectionsCategories else {
        print("createTestSetupInfo: Number of colours given (\(colours.count)) does not equal number of connectionsCategories (\(numConnectionsCategories)).")
        throw ValidationError.invalidInput
    }

    var connectionsCategoryInfos: [ConnectionsCategoryInfo] = []
    for connectionsCategoryNumber in 0...numConnectionsCategories - 1 {
        connectionsCategoryInfos.append(ConnectionsCategoryInfo(name: "Category \(connectionsCategoryNumber)", colour: colours[connectionsCategoryNumber], clues: createDefaultClues(numCluesPerConnectionsCategory: numCluesPerConnectionsCategory, connectionsCategoryNumber: connectionsCategoryNumber)))
    }
    return connectionsCategoryInfos
}

func createDefaultTestSetupInfo() -> SetupInfo {
    let numConnectionsCategories: Int = 4
    let colours: [Color] = [.yellow, .green, .blue, .purple]
    let numCluesPerConnectionsCategory: Int = 4
    
    // Shouldn't fail anyway, but if it does I want it to crash.
    let connectionsCategoryInfos: [ConnectionsCategoryInfo] = try! createTestConnectionsCategoryInfos(numConnectionsCategories: numConnectionsCategories, colours: colours, numCluesPerConnectionsCategory: numCluesPerConnectionsCategory)
    return SetupInfo(connectionsCategoryInfos: connectionsCategoryInfos, numMistakes: 4)
}

func connectionsCategoriesCompletedInIncreasingOrder(connectionsCategory1: ConnectionsCategory, connectionsCategory2: ConnectionsCategory) -> Bool {
    if let orderCompleted1 = connectionsCategory1.orderCompleted, let orderCompleted2 = connectionsCategory2.orderCompleted {
        return orderCompleted1 < orderCompleted2
    } else if connectionsCategory1.isCompleted {
        return true
    } else if connectionsCategory2.isCompleted {
        return false
    } else {
        return true
    }
}

func createConnectionsCategoryClueInfos(clues: [String], connectionsCategoryID: UUID) -> [ClueInfo] {
    return clues.map({clue in
            ClueInfo(clue: clue, connectionsCategoryID: connectionsCategoryID)
    })
}

func createClueBoxes(setupInfo: SetupInfo) -> [ClueBox] {
    return setupInfo.connectionsCategoryInfos.flatMap { catInfo in
        catInfo.clueInfos.map { clueInfo in
            ClueBox(clueInfo: clueInfo)
        }
    }
}

func createConnectionsCategories(connectionsCategoryInfos: [ConnectionsCategoryInfo]) -> [ConnectionsCategory] {
    return connectionsCategoryInfos.map{connectionsCategoryInfo in
        ConnectionsCategory(connectionsCategoryInfo: connectionsCategoryInfo)
    }
}
