//
//  Popup.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 06.01.26.
//

import Foundation

@Observable
class Popup {
    var trigger: Bool = false // Actual value doesn't matter, but must change to trigger OneAway/AlreadyGuessed.
    var text: String = ""
    let oneAwayText: String = "One away!"
    let alreadyGuessedText: String = "Already guessed!"
    
    func activate(text: String) {
        self.text = text
        self.trigger.toggle()
    }
    
    func activateOneAway() {
        activate(text: self.oneAwayText)
    }
    
    func activateAlreadyGuessed() {
        activate(text: self.alreadyGuessedText)
    }
}
