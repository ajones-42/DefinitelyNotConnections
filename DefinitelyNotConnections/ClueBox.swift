//
//  ClueBox.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import Foundation

@Observable
class ClueBox: Identifiable {
    let text: String
    var isSelected: Bool
    let id: Int
    
    init(text: String, isSelected: Bool, id: Int) {
        self.text = text
        self.isSelected = isSelected
        self.id = id
    }
    
    convenience init(text: String, id: Int) {
        self.init(text: text, isSelected: false, id: id)
    }
    
    func click() {
        self.isSelected.toggle()
    }
    
    func deselect() {
        self.isSelected = false
    }
}
