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

func createDefaultTestCategoryInfos() -> [CategoryInfo] {
    var categoryInfos: [CategoryInfo] = []
    categoryInfos.append(CategoryInfo(name: "Category 0", colour: .yellow, clues: ["Clue 0", "Clue 1", "Clue 2", "Clue 3"]))
    categoryInfos.append(CategoryInfo(name: "Category 1", colour: .green, clues: ["Clue 4", "Clue 5", "Clue 6", "Clue 7"]))
    categoryInfos.append(CategoryInfo(name: "Category 2", colour: .blue, clues: ["Clue 8", "Clue 9", "Clue 10", "Clue 11"]))
    categoryInfos.append(CategoryInfo(name: "Category 3", colour: .purple, clues: ["Clue 12", "Clue 13", "Clue 14", "Clue 15"]))
    return categoryInfos
}

func createDefaultTestSetupInfo() -> SetupInfo {
    return SetupInfo(numCluesPerCategory: 4, categoryInfos: createDefaultTestCategoryInfos())
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
