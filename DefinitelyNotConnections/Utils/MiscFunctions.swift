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
    // If I ever expect one array to be much larger than the other, it may be worth finding and iterating over smaller array
    var numSameElements: Int = 0
    for lhElement in lhs {
        numSameElements += (rhs.contains(lhElement)) ? 1 : 0
    }
    return numSameElements
}

func createDefaultClues(numCluesPerCategory: Int, categoryNumber: Int) -> [String] {
    var clues: [String] = []
    for clueNumber in 0...numCluesPerCategory - 1 {
        clues.append("Clue \(numCluesPerCategory * categoryNumber + clueNumber)")
    }
    return clues
}

func createTestCategoryInfos(numCategories: Int, colours: [Color], numCluesPerCategory: Int) -> [CategoryInfo] {
    var categoryInfos: [CategoryInfo] = []
    for categoryNumber in 0...numCategories - 1 {
        categoryInfos.append(CategoryInfo(name: "Category \(categoryNumber)", colour: colours[categoryNumber], clues: createDefaultClues(numCluesPerCategory: numCluesPerCategory, categoryNumber: categoryNumber)))
    }
    return categoryInfos
}

func createTestSetupInfo(numCategories: Int, colours: [Color], numCluesPerCategory: Int) -> SetupInfo {
    return SetupInfo(numCluesPerCategory: numCluesPerCategory, categoryInfos: createTestCategoryInfos(numCategories: numCategories, colours: colours, numCluesPerCategory: numCluesPerCategory))
}

func createDefaultTestSetupInfo() -> SetupInfo {
    return createTestSetupInfo(numCategories: 4, colours: [.yellow, .green, .blue, .purple], numCluesPerCategory: 4)
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
