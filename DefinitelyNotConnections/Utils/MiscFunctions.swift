//
//  MiscFunctions.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 23.06.25.
//

import Foundation

func concatBoxTexts(clueBoxes: [ClueBox]) -> String {
    let boxTexts = clueBoxes.map({ $0.text })
    return boxTexts.joined(separator: ", ")
}

func getClueBoxIDs(clueBoxes: [ClueBox]) -> [Int] {
    return clueBoxes.map({ $0.id })
}
