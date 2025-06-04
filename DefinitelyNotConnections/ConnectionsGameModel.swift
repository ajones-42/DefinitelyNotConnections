//
//  ConnectionsGameModel.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import Foundation
import SwiftUI

struct ConnectionsGameModel {
    var allClueTexts: [String] = ["Clue0", "Clue1", "Clue2", "Clue3", "Clue4", "Clue5", "Clue6", "Clue7", "Clue8", "Clue9", "Clue10", "Clue11", "Clue12", "Clue13", "Clue14", "Clue15", "Clue15"]
    var boxColours: [Color] = [.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray]
    var textColours: [Color] = [.black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black]
    // Lots of repeated information, but is easiest to start with
    // var boxesSelectedMap: [Int: Bool] = [0:false, 1:false, 2:false, 3:false, 4:false, 5:false, 6:false, 7:false, 8:false, 9:false, 10:false, 11:false, 12:false, 13:false, 14:false, 15:false]
    var selectedBoxes = Set<Int>()
    var numSelectedBoxes: Int {
        selectedBoxes.count
    }
    var numMistakesRemaining: Int = 4
    var mistakesRemainingCircle1Colour: Color {
        (numMistakesRemaining > 0) ? .black : .white
    }
    var mistakesRemainingCircle2Colour: Color {
        (numMistakesRemaining > 1) ? .black : .white
    }
    var mistakesRemainingCircle3Colour: Color {
        (numMistakesRemaining > 2) ? .black : .white
    }
    var mistakesRemainingCircle4Colour: Color {
        (numMistakesRemaining > 3) ? .black : .white
    }
    
    var submitBoxColour: Color {
        (numSelectedBoxes == 4) ? .black : .white
    }
    
    var submitTextColour: Color {
        (numSelectedBoxes == 4) ? .white : .black
    }
    
    var deselectAllBoxColour: Color {
        (numSelectedBoxes > 0) ? .black : .white
    }
    
    var deselectAllTextColour: Color {
        (numSelectedBoxes > 0) ? .white : .black
    }
    
    
    
    mutating func clickClueBox(clueBoxPosition: Int) {
        if boxIsSelected(clueBoxPosition: clueBoxPosition) {
            clickSelectedBox(clueBoxPosition: clueBoxPosition)
        } else if numSelectedBoxes < 4 {
            clickUnselectedBox(clueBoxPosition: clueBoxPosition)
        }
    }
    
    func boxIsSelected(clueBoxPosition: Int) -> Bool {
        return selectedBoxes.contains(clueBoxPosition)
    }
    
    mutating func clickSelectedBox(clueBoxPosition: Int) {
        //boxesSelectedMap[clueBoxPosition]?.toggle()
        // This shouldn't be able to fail
        if let _ = selectedBoxes.remove(clueBoxPosition) {}
        boxColours[clueBoxPosition] = .gray
        textColours[clueBoxPosition] = .black
    }

    mutating func clickUnselectedBox(clueBoxPosition: Int) {
        //boxesSelectedMap[clueBoxPosition]?.toggle()
        selectedBoxes.insert(clueBoxPosition)
        boxColours[clueBoxPosition] = .black
        textColours[clueBoxPosition] = .white
    }
    
    mutating func clickSubmit() {
        if numSelectedBoxes == 4 {
            numMistakesRemaining -= 1
            deselectAll()
        }
    }
    
    mutating func deselectAll() {
        selectedBoxes.removeAll()
        boxColours = [.gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray, .gray]
        textColours = [.black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black, .black]
    }
}
