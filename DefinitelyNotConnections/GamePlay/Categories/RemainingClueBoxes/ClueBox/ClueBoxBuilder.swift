//
//  ClueBoxBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

class ClueBoxBuilder {
    var clueInfo: ClueInfo = ClueInfo(clue: "A clue!")
    var isCompleted: Bool = false
    var isSelected: Bool = false
    var shake: Bool = false
    
    func withIsCompleted(isCompleted: Bool) -> ClueBoxBuilder {
        self.isCompleted = isCompleted
        return self
    }

    func withIsSelected(isSelected: Bool) -> ClueBoxBuilder {
        self.isSelected = isSelected
        return self
    }

    func withShake(shake: Bool) -> ClueBoxBuilder {
        self.shake = shake
        return self
    }
    
    func withClueInfo(clueInfo: ClueInfo) -> ClueBoxBuilder {
        self.clueInfo = clueInfo
        return self
    }

    func build() -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: self.isCompleted, isSelected: self.isSelected, shake: self.shake)
    }
}
