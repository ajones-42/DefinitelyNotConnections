//
//  Popup.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 06.01.26.
//

import Foundation

@Observable
class Popup {
    var isPresented: Bool = false
    var text: String = ""
    
    func activate(text: String) {
        self.text = text
        self.isPresented = true
    }
    
    func deactivate() {
        self.isPresented = false
    }
    
    func showMomentarily(duration: TimeInterval, text: String) {
        activate(text: text)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.deactivate()
        }
    }
    
    func activateOneAway() {
        showMomentarily(duration: TimeInterval(2), text: "One away!")
    }
    
    func activateAlreadyGuessed() {
        showMomentarily(duration: TimeInterval(2), text: "Already guessed!")
    }
}
