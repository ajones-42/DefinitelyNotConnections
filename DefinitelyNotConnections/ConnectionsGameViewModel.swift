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
    
    
    // All colours should probably be defined in views tracking a boolean defined here
    var mistakesRemainingCircle1Shown: Bool {
        (numMistakesRemaining > 0) ? true : false
    }
    var mistakesRemainingCircle2Shown: Bool {
        (numMistakesRemaining > 1) ? true : false
    }
    var mistakesRemainingCircle3Shown: Bool {
        (numMistakesRemaining > 2) ? true : false
    }
    var mistakesRemainingCircle4Shown: Bool {
        (numMistakesRemaining > 3) ? true : false
    }
    
    var numMistakesRemaining: Int {
        connectionsGameModel.numMistakesRemaining
    }
    
    var submitBoxColour: Color {
        (connectionsGameModel.numSelectedBoxes == 4) ? Color(UIColor.systemGray) : Color(UIColor.systemGray6)
    }
    
    var submitTextColour: Color {
        (connectionsGameModel.numSelectedBoxes == 4) ? .white : Color(UIColor.systemGray4)
    }
    
    var deselectAllBoxColour: Color {
        (connectionsGameModel.numSelectedBoxes > 0) ? Color(UIColor.systemGray) : Color(UIColor.systemGray6)
    }
    
    var deselectAllTextColour: Color {
        (connectionsGameModel.numSelectedBoxes > 0) ? .white : Color(UIColor.systemGray4)
    }
    
    var clueBoxes: [ConnectionsGameModel.Category.ClueBox] {
        connectionsGameModel.clueBoxes
    }
    
    var completedCategories: [ConnectionsGameModel.Category] {
        connectionsGameModel.completedCategories
    }
    
    func clickClueBox(clueBox: ConnectionsGameModel.Category.ClueBox) {
        if connectionsGameModel.numSelectedBoxes < 4 || clueBox.isSelected {
            connectionsGameModel.clickBox(clueBox: clueBox)
        }
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
    
    func clickShuffle() {
        connectionsGameModel.shuffleClueBoxes()
    }
    
    func resetNumMistakesRemaining() {
        connectionsGameModel.resetNumMistakesRemaining()
    }
}
