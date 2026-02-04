//
//  Guess.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation
import SwiftUI

struct Guess: Identifiable, Equatable {
    let clueInfos: [ClueInfo]
    let isCorrect: Bool
    let isOneAway: Bool
    let id: UUID
    var displayColour: Color {
        if self.isCorrect {
            return .green
        } else if self.isOneAway {
            return .yellow
        } else {
            return .red
        }
    }
    
    init(clueInfos: [ClueInfo], submitBestMatch: SubmitBestMatch) {
        self.clueInfos = clueInfos
        self.isCorrect = submitBestMatch.isCorrect
        self.isOneAway = submitBestMatch.isOneAway
        self.id = UUID()
    }
    
    init(clueInfos: [ClueInfo], isCorrect: Bool, isOneAway: Bool, id: UUID) {
        self.clueInfos = clueInfos
        self.isCorrect = isCorrect
        self.isOneAway = isOneAway
        self.id = id
    }
    
    func getClueIDs() -> [UUID] {
        return self.clueInfos.map({clueInfo in
            clueInfo.getID()})
    }
    
    func getClues() -> [String] {
        return self.clueInfos.map({clueInfo in
            clueInfo.getClue()})
    }
    
    func getGuessText() -> String {
        return "\(concatClues(clues: getClues()))"
    }
    
    func clueBoxesMatchGuess(clueBoxIDs: [UUID]) -> Bool {
        let guessClueBoxIDs: [UUID] = getClueIDs()
        return guessClueBoxIDs.count == clueBoxIDs.count ? getNumSameElementsInArrays(lhs: clueBoxIDs, rhs: guessClueBoxIDs) == guessClueBoxIDs.count : false
    }
}
