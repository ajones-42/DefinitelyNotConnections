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
    let completedClueBox: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: true).build()
    let uncompletedClueBox: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: false).build()
    let selectedCompletedShakingClueBox: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: true).withShake(shake: true).build()
    
    // Reset
    @Test func resetClueBox() {
        let clueBox: ClueBox = selectedCompletedShakingClueBox
        clueBox.reset()
        #expect(clueBox.isSelected == false && clueBox.isCompleted == false && clueBox.shake == false)
    }

    // Click
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
    
    // Deselect
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
    
    // Select
    @Test func selectSelectedClueBox() {
        let clueBox: ClueBox = selectedClueBox
        clueBox.select()
        #expect(clueBox.isSelected == true)
    }
    
    @Test func selectUnselectedClueBox() {
        let clueBox: ClueBox = unselectedClueBox
        clueBox.select()
        #expect(clueBox.isSelected == true)
    }
    
    // Shake
    @Test func shakeStillClueBox() {
        let clueBox: ClueBox = stillClueBox
        clueBox.startShake()
        #expect(clueBox.shake == true)
    }
    
    @Test func shakeShakingClueBox() {
        let clueBox: ClueBox = shakingClueBox
        clueBox.startShake()
        #expect(clueBox.shake == true)
    }
    
    // Stop shake
    @Test func unshakeStillClueBox() {
        let clueBox: ClueBox = stillClueBox
        clueBox.stopShake()
        #expect(clueBox.shake == false)
    }
    
    @Test func unshakeShakingClueBox() {
        let clueBox: ClueBox = shakingClueBox
        clueBox.stopShake()
        #expect(clueBox.shake == false)
    }
    
    // Set completed
    @Test func completeUncompletedClueBox() {
        let clueBox: ClueBox = uncompletedClueBox
        clueBox.setCompleted()
        #expect(clueBox.isCompleted == true)
    }
    
    @Test func completeCompleteClueBox() {
        let clueBox: ClueBox = completedClueBox
        clueBox.setCompleted()
        #expect(clueBox.isCompleted == true)
    }
}
