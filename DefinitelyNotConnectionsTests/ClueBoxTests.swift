//
//  ClueBoxTests.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.12.25.
//

import Testing
@testable import DefinitelyNotConnections

@Suite struct ClueBoxTests {
    
    // Reset
    @Test func resetClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: true).withShake(shake: true).build()
        clueBox.reset()
        #expect(clueBox.isSelected == false && clueBox.isCompleted == false && clueBox.shake == false)
    }

    // Click
    @Test func clickSelectedClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        clueBox.click()
        #expect(clueBox.isSelected == false)
    }
    
    @Test func clickUnselectedClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        clueBox.click()
        #expect(clueBox.isSelected == true)
    }
    
    // Deselect
    @Test func deselectSelectedClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        clueBox.deselect()
        #expect(clueBox.isSelected == false)
    }
    
    @Test func deselectUnselectedClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        clueBox.deselect()
        #expect(clueBox.isSelected == false)
    }
    
    // Select
    @Test func selectSelectedClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        clueBox.select()
        #expect(clueBox.isSelected == true)
    }
    
    @Test func selectUnselectedClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        clueBox.select()
        #expect(clueBox.isSelected == true)
    }
    
    // Shake
    @Test func shakeStillClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withShake(shake: false).build()
        clueBox.startShake()
        #expect(clueBox.shake == true)
    }
    
    @Test func shakeShakingClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withShake(shake: true).build()
        clueBox.startShake()
        #expect(clueBox.shake == true)
    }
    
    // Stop shake
    @Test func unshakeStillClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withShake(shake: false).build()
        clueBox.stopShake()
        #expect(clueBox.shake == false)
    }
    
    @Test func unshakeShakingClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withShake(shake: true).build()
        clueBox.stopShake()
        #expect(clueBox.shake == false)
    }
    
    // Set completed
    @Test func completeUncompletedClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: false).build()
        clueBox.setCompleted()
        #expect(clueBox.isCompleted == true)
    }
    
    @Test func completeCompleteClueBox() {
        let clueBox: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: true).build()
        clueBox.setCompleted()
        #expect(clueBox.isCompleted == true)
    }
}

