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

func createTestCategory(categoryNumber: Int, numCluesPerCategory: Int, colour: Color) -> Category {
    let categoryName: String = "Category \(categoryNumber)"
    var clueBoxTexts: [String] = []

    for clueBoxNumber in 0...numCluesPerCategory {
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
