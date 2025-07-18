//
//  ClueBoxBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 19.07.25.
//

import Foundation

struct ClueBoxBuilder {
    var text: String = "A clue!"
    var isSelected: Bool = false
    var id: Int = 0

    mutating func withText(text: String) -> ClueBoxBuilder {
        self.text = text
        return self
    }
    
    mutating func withIsSelected(isSelected: Bool) -> ClueBoxBuilder {
        self.isSelected = isSelected
        return self
    }
    
    mutating func withID(id: Int) -> ClueBoxBuilder {
        self.id = id
        return self
    }
    
    func build() -> ClueBox {
        return ClueBox(text: self.text, isSelected: self.isSelected, id: self.id)
    }
}
