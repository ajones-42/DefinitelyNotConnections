//
//  Popup.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 06.01.26.
//

import Foundation

struct Popup {
    let message: String
    let isPresented: Bool
    
    init(message: String, isPresented: Bool) {
        self.message = message
        self.isPresented = isPresented
    }
    
    init() {
        self.message = ""
        self.isPresented = false
    }
}
