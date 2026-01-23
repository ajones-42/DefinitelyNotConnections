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
    return lhs.map({rhs.contains($0) ? 1 : 0}).reduce(0, {x, y in
        x + y
    })
}

func createDefaultClues(numCluesPerCategory: Int, categoryNumber: Int) -> [String] {
    var clues: [String] = []
    for clueNumber in 0...numCluesPerCategory - 1 {
        clues.append("Clue \(numCluesPerCategory * categoryNumber + clueNumber)")
    }
    return clues
}

func createTestSetupInfo(numCategories: Int, colours: [Color], numCluesPerCategory: Int) throws -> SetupInfo {
    guard colours.count == numCategories else {
        print("createTestSetupInfo: Number of colours given (\(colours.count)) does not equal number of categories (\(numCategories)).")
        throw ValidationError.invalidInput
    }

    var categoryInfos: [CategoryInfo] = []
    for categoryNumber in 0...numCategories - 1 {
        categoryInfos.append(CategoryInfo(name: "Category \(categoryNumber)", colour: colours[categoryNumber], clues: createDefaultClues(numCluesPerCategory: numCluesPerCategory, categoryNumber: categoryNumber)))
    }
    return SetupInfo(numCluesPerCategory: numCluesPerCategory, categoryInfos: categoryInfos)
}

func createDefaultTestSetupInfo() -> SetupInfo {
    let numCategories: Int = 4
    let colours: [Color] = [.yellow, .green, .blue, .purple]
    let numCluesPerCategory: Int = 4
    
    // Shouldn't fail anyway, but if it does I want it to crash.
    return try! createTestSetupInfo(numCategories: numCategories, colours: colours, numCluesPerCategory: numCluesPerCategory)
}

func categoriesCompletedInIncreasingOrder(category1: Category, category2: Category) -> Bool {
    if let orderCompleted1 = category1.orderCompleted, let orderCompleted2 = category2.orderCompleted {
        return orderCompleted1 < orderCompleted2
    } else if category1.isCompleted {
        return true
    } else if category2.isCompleted {
        return false
    } else {
        return true
    }
}
