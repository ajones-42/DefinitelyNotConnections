//
//  Guess.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation
import SwiftUI

struct Guess: Identifiable {
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
    
    init(clueInfos: [ClueInfo], submitResult: SubmitResult) {
        self.clueInfos = clueInfos
        self.isCorrect = submitResult.isCorrect
        self.isOneAway = submitResult.isOneAway
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
            clueInfo.id})
    }
    
    func getClues() -> [String] {
        return self.clueInfos.map({clueInfo in
            clueInfo.clue})
    }
    
    func getGuessText() -> String {
        return "\(concatClues(clues: getClues()))"
    }
    
    func clueBoxesMatchGuess(clueBoxIDs: [UUID]) -> Bool {
        let guessClueBoxIDs: [UUID] = getClueIDs()
        return getNumSameElementsInArrays(lhs: clueBoxIDs, rhs: guessClueBoxIDs) == guessClueBoxIDs.count
    }
}
