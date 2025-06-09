//
//  ViewModel.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 05.06.25.
//

import Foundation
import SwiftUI

class ConnectionsGameViewModel {
    @State private var connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    
    var mistakesRemainingCircle1Colour: Color {
        (connectionsGameModel.numMistakesRemaining > 0) ? .black : .white
    }
    var mistakesRemainingCircle2Colour: Color {
        (connectionsGameModel.numMistakesRemaining > 1) ? .black : .white
    }
    var mistakesRemainingCircle3Colour: Color {
        (connectionsGameModel.numMistakesRemaining > 2) ? .black : .white
    }
    var mistakesRemainingCircle4Colour: Color {
        (connectionsGameModel.numMistakesRemaining > 3) ? .black : .white
    }
    
    var submitBoxColour: Color {
        (connectionsGameModel.numSelectedBoxes == 4) ? .black : .white
    }
    
    var submitTextColour: Color {
        (connectionsGameModel.numSelectedBoxes == 4) ? .white : .black
    }
    
    var deselectAllBoxColour: Color {
        (connectionsGameModel.numSelectedBoxes > 0) ? .black : .white
    }
    
    var deselectAllTextColour: Color {
        (connectionsGameModel.numSelectedBoxes > 0) ? .white : .black
    }
    
    var clueBoxes: [ConnectionsGameModel.ClueBox] {
        connectionsGameModel.clueBoxes
    }
    
    var categories: [ConnectionsGameModel.Category] {
        connectionsGameModel.categories
    }
    
    func clickClueBox(clueBox: ConnectionsGameModel.ClueBox) {
        connectionsGameModel.clickBox(clueBox: clueBox)
    }
    
    func clickDeselectAll() {
        // 1. Does this actually need check? 2. Should model check?
        if connectionsGameModel.numSelectedBoxes > 0 {
            connectionsGameModel.deselectAll()
        }
    }
    
    func clickSubmit() {
        if connectionsGameModel.numSelectedBoxes == 4 {
            connectionsGameModel.submit()
        }
    }
}
