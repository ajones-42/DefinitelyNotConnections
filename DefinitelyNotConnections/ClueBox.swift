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
    let id: Int
    
    init(text: String, isSelected: Bool, shake: Bool, id: Int) {
        self.text = text
        self.isSelected = isSelected
        self.shake = shake
        self.id = id
    }
    
    init(text: String, id: Int) {
        self.init(text: text, isSelected: false, shake: false, id: id)
    }
    
    //static func ==(lhs: ClueBox, rhs: ClueBox) -> Bool {
    //    return lhs.id == rhs.id && lhs.text == rhs.text
    //}
    
    func click() -> ClueBox {
        return ClueBox(text: self.text, isSelected: !self.isSelected, shake: self.shake, id: self.id)
    }
    
    func deselect() -> ClueBox {
        return ClueBox(text: self.text, isSelected: false, shake: self.shake, id: self.id)
    }
    
    func startShake() -> ClueBox {
        return ClueBox(text: self.text, isSelected: self.isSelected, shake: true, id: self.id)
    }
    
    func stopShake() -> ClueBox {
        return ClueBox(text: self.text, isSelected: self.isSelected, shake: false, id: self.id)
    }
}
