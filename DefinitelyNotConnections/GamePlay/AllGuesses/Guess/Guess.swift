//
//  Guess.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation
import SwiftUI

struct Guess: Identifiable {
    let clueBoxIDs: [UUID]
    let clues: [String]
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
    
    init(clues: [String], clueBoxIDs: [UUID], submitResult: SubmitResult) {
        self.clues = clues
        self.clueBoxIDs = clueBoxIDs
        self.isCorrect = submitResult.isCorrect
        self.isOneAway = submitResult.isOneAway
        self.id = UUID()
    }
    
    func getGuessText() -> String {
        return "\(concatClues(clues: self.clues))"
    }
}
