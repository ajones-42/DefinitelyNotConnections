//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation

struct ClueBox: Identifiable, Equatable {
    let clue: String
    let isSelected: Bool
    let shake: Bool
    let id: UUID = UUID()
    
    init(clue: String, isSelected: Bool, shake: Bool) {
        self.clue = clue
        self.isSelected = isSelected
        self.shake = shake
    }
    
    init(clue: String) {
        self.init(clue: clue, isSelected: false, shake: false)
    }
    
    //static func ==(lhs: ClueBox, rhs: ClueBox) -> Bool {
    //    return lhs.id == rhs.id && lhs.text == rhs.text
    //}
    
    func click() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: !self.isSelected, shake: self.shake)
    }
    
    func deselect() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: false, shake: self.shake)
    }
    
    func startShake() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: self.isSelected, shake: true)
    }
    
    func stopShake() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: self.isSelected, shake: false)
    }
}
