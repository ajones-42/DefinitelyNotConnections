//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation

struct ClueBox: Identifiable, Equatable {
    let text: String
    let isSelected: Bool
    let shake: Bool
    let id: UUID = UUID()
    
    init(text: String, isSelected: Bool, shake: Bool) {
        self.text = text
        self.isSelected = isSelected
        self.shake = shake
    }
    
    init(text: String) {
        self.init(text: text, isSelected: false, shake: false)
    }
    
    //static func ==(lhs: ClueBox, rhs: ClueBox) -> Bool {
    //    return lhs.id == rhs.id && lhs.text == rhs.text
    //}
    
    func click() -> ClueBox {
        return ClueBox(text: self.text, isSelected: !self.isSelected, shake: self.shake)
    }
    
    func deselect() -> ClueBox {
        return ClueBox(text: self.text, isSelected: false, shake: self.shake)
    }
    
    func startShake() -> ClueBox {
        return ClueBox(text: self.text, isSelected: self.isSelected, shake: true)
    }
    
    func stopShake() -> ClueBox {
        return ClueBox(text: self.text, isSelected: self.isSelected, shake: false)
    }
}
