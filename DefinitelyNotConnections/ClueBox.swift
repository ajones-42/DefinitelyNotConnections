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
    var isSelected: Bool = false
    let id: Int
    
    init(text: String, id: Int) {
        self.text = text
        self.id = id
    }
    
    func click() {
        self.isSelected.toggle()
    }
}
