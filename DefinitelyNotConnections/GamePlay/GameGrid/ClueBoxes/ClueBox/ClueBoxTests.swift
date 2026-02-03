//
//  ClueBoxTests.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.12.25.
//

import Testing
@testable import DefinitelyNotConnections

@Suite struct ClueBoxTests {
    let selectedClueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
    let unselectedClueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
    let shakingClueBox: ClueBox = ClueBoxBuilder().withShake(shake: true).build()
    let stillClueBox: ClueBox = ClueBoxBuilder().withShake(shake: false).build()

    @Test func clickSelectedClueBox() {
        let clueBox: ClueBox = selectedClueBox
        clueBox.click()
        #expect(clueBox.isSelected == false)
    }
    
    @Test func clickUnselectedClueBox() {
        let clueBox: ClueBox = unselectedClueBox
        clueBox.click()
        #expect(clueBox.isSelected == true)
    }
    
    @Test func deselectSelectedClueBox() {
        let clueBox: ClueBox = selectedClueBox
        clueBox.deselect()
        #expect(clueBox.isSelected == false)
    }
    
    @Test func deselectUnselectedClueBox() {
        let clueBox: ClueBox = unselectedClueBox
        clueBox.deselect()
        #expect(clueBox.isSelected == false)
    }
    
    @Test func ShakeStillClueBox() {
        let clueBox: ClueBox = stillClueBox
        clueBox.startShake()
        #expect(clueBox.shake == true)
    }
    
    @Test func ShakeShakingClueBox() {
        let clueBox: ClueBox = shakingClueBox
        clueBox.startShake()
        #expect(clueBox.shake == true)
    }
    
    @Test func UnshakeStillClueBox() {
        let clueBox: ClueBox = stillClueBox
        clueBox.stopShake()
        #expect(clueBox.shake == false)
    }
    
    @Test func UnshakeShakingClueBox() {
        let clueBox: ClueBox = shakingClueBox
        clueBox.stopShake()
        #expect(clueBox.shake == false)
    }
}
