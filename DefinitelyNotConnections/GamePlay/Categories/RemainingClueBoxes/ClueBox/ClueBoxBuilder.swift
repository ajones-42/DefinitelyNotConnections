//
//  ClueBoxBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

class ClueBoxBuilder {
    var clue: String = "A clue!"
    var isSelected: Bool = false
    var shake: Bool = false
    var id: UUID = UUID()

    func withClue(clue: String) -> ClueBoxBuilder {
        self.clue = clue
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
    
    func withID(id: UUID) -> ClueBoxBuilder {
        self.id = id
        return self
    }

    func build() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: self.isSelected, shake: self.shake, id: self.id)
    }
}
