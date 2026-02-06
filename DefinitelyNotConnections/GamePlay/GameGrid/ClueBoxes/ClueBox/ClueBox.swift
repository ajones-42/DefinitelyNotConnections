//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation

@Observable
class ClueBox {
    let clueInfo: ClueInfo
    private(set) var isCompleted: Bool
    private(set) var isSelected: Bool
    private(set) var shake: Bool
    
    init(clueInfo: ClueInfo) {
        self.clueInfo = clueInfo
        self.isCompleted = false
        self.isSelected = false
        self.shake = false
    }
    
    init(clueInfo: ClueInfo, isCompleted: Bool, isSelected: Bool, shake: Bool) {
        self.clueInfo = clueInfo
        self.isCompleted = isCompleted
        self.isSelected = isSelected
        self.shake = shake
    }
    
    func reset() {
        self.isCompleted = false
        self.isSelected = false
        self.shake = false
    }
    
    func click() {
        self.isSelected.toggle()
    }
    
    func select() {
        self.isSelected = true
    }
    
    func deselect() {
        self.isSelected = false
    }
    
    func startShake() {
        self.shake = true
    }
    
    func stopShake() {
        self.shake = false
    }
    
    func setCompleted() {
        self.isCompleted = true
    }
    
    func getID() -> UUID {
        return self.clueInfo.getID()
    }
    
    func getClue() -> String {
        return self.clueInfo.getClue()
    }
    
    func getConnectionsCategoryID() -> UUID {
        return self.clueInfo.getConnectionsCategoryID()
    }
}
