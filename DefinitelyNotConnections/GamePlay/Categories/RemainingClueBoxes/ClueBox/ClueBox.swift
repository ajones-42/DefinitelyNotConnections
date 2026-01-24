//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation

struct ClueBox: Equatable {
    let clueInfo: ClueInfo
    let isCompleted: Bool
    let isSelected: Bool
    let shake: Bool
    
    init(clueInfo: ClueInfo) {
        self.init(clueInfo: clueInfo, isCompleted: false, isSelected: false, shake: false)
    }
    
    init(clueInfo: ClueInfo, isCompleted: Bool, isSelected: Bool, shake: Bool) {
        self.clueInfo = clueInfo
        self.isCompleted = isCompleted
        self.isSelected = isSelected
        self.shake = shake
    }
    
    private func recomputeClueBox(newIsCompleted: Bool, newIsSelected: Bool, newShake: Bool) -> ClueBox {
        return ClueBox(clueInfo: self.clueInfo, isCompleted: newIsCompleted, isSelected: newIsSelected, shake: newShake)
    }
    
    func reset() -> ClueBox {
        return recomputeClueBox(newIsCompleted: false, newIsSelected: false, newShake: false)
    }
    
    func click() -> ClueBox {
        return recomputeClueBox(newIsCompleted: self.isCompleted, newIsSelected: !self.isSelected, newShake: self.shake)
    }
    
    func deselect() -> ClueBox {
        return recomputeClueBox(newIsCompleted: self.isCompleted, newIsSelected: false, newShake: self.shake)
    }
    
    func startShake() -> ClueBox {
        return recomputeClueBox(newIsCompleted: self.isCompleted, newIsSelected: self.isSelected, newShake: true)
    }
    
    func stopShake() -> ClueBox {
        return recomputeClueBox(newIsCompleted: self.isCompleted, newIsSelected: self.isSelected, newShake: false)
    }
    
    func setCompleted() -> ClueBox {
        return recomputeClueBox(newIsCompleted: true, newIsSelected: self.isSelected, newShake: self.shake)
    }
    
    func setUncompleted() -> ClueBox {
        return recomputeClueBox(newIsCompleted: false, newIsSelected: self.isSelected, newShake: self.shake)
    }
    
    func getID() -> UUID {
        return self.clueInfo.id
    }
    
    func getClue() -> String {
        return self.clueInfo.clue
    }
}
