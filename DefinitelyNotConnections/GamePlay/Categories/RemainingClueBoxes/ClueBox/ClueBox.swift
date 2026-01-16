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
    let id: UUID
    
    init(clue: String, isSelected: Bool, shake: Bool, id: UUID) {
        self.clue = clue
        self.isSelected = isSelected
        self.shake = shake
        self.id = id
    }
    
    init(clue: String, id: UUID) {
        self.init(clue: clue, isSelected: false, shake: false, id:id)
    }
    
    //static func ==(lhs: ClueBox, rhs: ClueBox) -> Bool {
    //    return lhs.id == rhs.id && lhs.text == rhs.text
    //}
    
    func click() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: !self.isSelected, shake: self.shake, id: self.id)
    }
    
    func deselect() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: false, shake: self.shake, id: self.id)
    }
    
    func startShake() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: self.isSelected, shake: true, id: self.id)
    }
    
    func stopShake() -> ClueBox {
        return ClueBox(clue: self.clue, isSelected: self.isSelected, shake: false, id: self.id)
    }
}
