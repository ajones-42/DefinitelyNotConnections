//
//  ClueBoxBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

class ClueBoxBuilder {
    var text: String = "A clue!"
    var isSelected: Bool = false
    var shake: Bool = false

    func withText(text: String) -> ClueBoxBuilder {
        self.text = text
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

    func build() -> ClueBox {
        return ClueBox(text: self.text, isSelected: self.isSelected, shake: self.shake)
    }
}
