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
    
    func getClues() -> [String] {
        return self.clueInfos.map({$0.clue})
    }
    
    func getGuessText() -> String {
        return "\(concatClues(clues: getClues()))"
    }
}
