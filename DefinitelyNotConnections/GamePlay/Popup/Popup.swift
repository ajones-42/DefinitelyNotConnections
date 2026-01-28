//
//  Popup.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 06.01.26.
//

import Foundation

@Observable
class Popup {
    private(set) var message: String
    private(set) var isActivated: Bool
    
    init() {
        self.message = ""
        self.isActivated = false
    }
    
    init(message: String, isActivated: Bool) {
        self.message = message
        self.isActivated = isActivated
    }
    
    private func activate(message: String) {
        self.message = message
        self.isActivated = true
    }
    
    func deactivate() {
        self.message = ""
        self.isActivated = false
    }
    
    func activateMomentarily(message: String, duration: TimeInterval) {
        activate(message: message)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.deactivate()
        }
    }
}
