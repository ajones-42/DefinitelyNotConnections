//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation

struct ClueBox: Equatable {
    let clueInfo: ClueInfo
    //let clue: String
    let isCompleted: Bool
    let isSelected: Bool
    let shake: Bool
    //let id: UUID
    
    init(clueInfo: ClueInfo) {
        //self.init(clue: clueInfo.clue, isCompleted: false, isSelected: false, shake: false, id: clueInfo.id)
        self.init(clueInfo: clueInfo, isCompleted: false, isSelected: false, shake: false)
    }
    
    init(clueInfo: ClueInfo, isCompleted: Bool, isSelected: Bool, shake: Bool) {
        self.clueInfo = clueInfo
        self.isCompleted = isCompleted
        self.isSelected = isSelected
        self.shake = shake
        //self.id = id
    }
    
    func reset() -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: false, isSelected: false, shake: false)
    }
    
    func click() -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: self.isCompleted, isSelected: !self.isSelected, shake: self.shake)
    }
    
    func deselect() -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: self.isCompleted, isSelected: false, shake: self.shake)
    }
    
    func startShake() -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: self.isCompleted, isSelected: self.isSelected, shake: true)
    }
    
    func stopShake() -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: self.isCompleted, isSelected: self.isSelected, shake: false)
    }
    
    func setCompleted() -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: true, isSelected: self.isSelected, shake: self.shake)
    }
    
    func setUncompleted() -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: false, isSelected: self.isSelected, shake: self.shake)
    }
}
