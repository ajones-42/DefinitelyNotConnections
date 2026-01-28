//
//  PopupBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 28.01.26.
//

import Foundation

class PopupBuilder {
    var message: String = "One Away!"
    var isActivated: Bool = false
    
    func withMessage(message: String) -> PopupBuilder {
        self.message = message
        return self
    }
    
    func withIsActivated(isActivated: Bool) -> PopupBuilder {
        self.isActivated = isActivated
        return self
    }
    
    func build() -> Popup {
        return Popup(message: self.message, isActivated: self.isActivated)
    }
}
