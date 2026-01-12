//
//  MiscFunctions.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 23.06.25.
//

import Foundation
import SwiftUI

func concatBoxTexts(clueBoxes: [ClueBox]) -> String {
    let boxTexts = clueBoxes.map({ $0.text })
    return boxTexts.joined(separator: ", ")
}

func getClueBoxIDs(clueBoxes: [ClueBox]) -> [Int] {
    return clueBoxes.map({ $0.id })
}

func getAllClueBoxes(categories: [Category]) -> [ClueBox] {
    return Array(categories.map({ $0.clueBoxes }).joined())
}

func getNumSameElementsInArrays<T: Equatable>(lhs: [T], rhs: [T]) -> Int {
    // If I ever expect one array to be much larger than the other, it may be worth finding and iterating over smaller array
    var numSameElements: Int = 0
    for lhElement in lhs {
        numSameElements += (rhs.contains(lhElement)) ? 1 : 0
    }
    return numSameElements
}

func createTestCategory(categoryNumber: Int, numCluesPerCategory: Int, colour: Color) -> Category {
    let categoryName: String = "Category \(categoryNumber)"
    var clueBoxTexts: [String] = []

    for clueBoxNumber in 0...numCluesPerCategory - 1 {
        clueBoxTexts.append("Clue \(clueBoxNumber + categoryNumber * numCluesPerCategory)")
    }
    return Category(name: categoryName, clueBoxTexts: clueBoxTexts, colour: colour, id: categoryNumber)
}

func createTestCategories(numCategories: Int, numCluesPerCategory: Int, colours: [Color]) throws -> [Category] {
    guard colours.count == numCategories else {
        throw ValidationError.invalidInput
    }
    var categories: [Category] = []

    for categoryNumber in 0...numCategories - 1 {
        categories.append(createTestCategory(categoryNumber: categoryNumber, numCluesPerCategory: numCluesPerCategory, colour: colours[categoryNumber]))
    }
    return categories
}

func createDefaultTestCategories() -> [Category] {
    let colours: [Color] = [.yellow, .green, .blue, .purple]
    let numCategories: Int = 4
    let numCluesPerCategory: Int = 4
    
    do {
        let categories: [Category] = try! createTestCategories(numCategories: numCategories, numCluesPerCategory: numCluesPerCategory, colours: colours)
        return categories
    }
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
