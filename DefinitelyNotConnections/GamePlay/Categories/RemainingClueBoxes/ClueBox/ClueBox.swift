//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation

struct ClueBox: Identifiable, Equatable {
    let clue: String
    let isCompleted: Bool
    let isSelected: Bool
    let shake: Bool
    let id: UUID
    
    init(clueInfo: ClueInfo) {
        self.init(clue: clueInfo.clue, isCompleted: false, isSelected: false, shake: false, id:clueInfo.id)
    }
    
    init(clue: String, isCompleted: Bool, isSelected: Bool, shake: Bool, id: UUID) {
        self.clue = clue
        self.isCompleted = isCompleted
        self.isSelected = isSelected
        self.shake = shake
        self.id = id
    }
    
    //static func ==(lhs: ClueBox, rhs: ClueBox) -> Bool {
    //    return lhs.id == rhs.id && lhs.text == rhs.text
    //}
    
    func click() -> ClueBox {
        return ClueBox(clue: self.clue, isCompleted: self.isCompleted, isSelected: !self.isSelected, shake: self.shake, id: self.id)
    }
    
    func deselect() -> ClueBox {
        return ClueBox(clue: self.clue, isCompleted: self.isCompleted, isSelected: false, shake: self.shake, id: self.id)
    }
    
    func startShake() -> ClueBox {
        return ClueBox(clue: self.clue, isCompleted: self.isCompleted, isSelected: self.isSelected, shake: true, id: self.id)
    }
    
    func stopShake() -> ClueBox {
        return ClueBox(clue: self.clue, isCompleted: self.isCompleted, isSelected: self.isSelected, shake: false, id: self.id)
    }
    
    func setCompleted() -> ClueBox {
        return ClueBox(clue: self.clue, isCompleted: true, isSelected: self.isSelected, shake: self.shake, id: self.id)
    }
    
    func setUncompleted() -> ClueBox {
        return ClueBox(clue: self.clue, isCompleted: false, isSelected: self.isSelected, shake: self.shake, id: self.id)
    }
}
