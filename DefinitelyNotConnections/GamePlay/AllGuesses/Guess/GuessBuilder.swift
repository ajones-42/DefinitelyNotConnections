//
//  GuessBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

class GuessBuilder {
    var clueInfos: [ClueInfo] = createConnectionsCategoryClueInfos(clues: createDefaultClues(numCluesPerConnectionsCategory: 4, connectionsCategoryNumber: 0), connectionsCategoryID: UUID())
    var isCorrect: Bool = false
    var isOneAway: Bool = false
    var id: UUID = UUID()
    
    func withClueInfos(clueInfos: [ClueInfo]) -> GuessBuilder {
        self.clueInfos = clueInfos
        return self
    }
    
    func withIsCorrect(isCorrect: Bool) -> GuessBuilder {
        self.isCorrect = isCorrect
        return self
    }
    
    func withIsOneAway(isOneAway: Bool) -> GuessBuilder {
        self.isOneAway = isOneAway
        return self
    }
    
    func withID(id: UUID) -> GuessBuilder {
        self.id = id
        return self
    }
    
    func build() -> Guess {
        return Guess(clueInfos: self.clueInfos, isCorrect: self.isCorrect, isOneAway: self.isOneAway, id: self.id)
    }
}
