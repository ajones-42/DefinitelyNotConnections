//
//  AllClueBoxesTests.swift
//  DefinitelyNotConnectionsTests
//
//  Created by Alex Jones on 08.02.26.
//

import Testing
import Foundation
@testable import DefinitelyNotConnections

@Suite struct AllClueBoxesTests {
    // RemainingClueBoxes
    @Test func testRemainingClueBoxesAll() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.numRemainingClueBoxes == 2)
    }
    
    @Test func testRemainingClueBoxesNone() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: true).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: true).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.numRemainingClueBoxes == 0)
    }
    
    @Test func testRemainingClueBoxesSome() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsCompleted(isCompleted: true).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.numRemainingClueBoxes == 1 && allClueBoxes.remainingClueBoxes.first === clueBox1)
    }
    
    // NumSelectedRemainingClueBoxes
    @Test func testNumSelectedRemainingClueBoxesAll() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 2)
    }
    
    @Test func testNumSelectedRemainingClueBoxesNone() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 0)
    }
    
    @Test func testNumSelectedRemainingClueBoxesSome() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 1)
    }
    
    // SelectedRemainingClueBoxes
    @Test func testSelectedRemainingClueBoxesAll() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 2 && allClueBoxes.allClueBoxes.contains(where: {$0 === clueBox1}) && allClueBoxes.allClueBoxes.contains(where: {$0 === clueBox2}))
    }
    
    @Test func testSelectedRemainingClueBoxesNone() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.selectedRemainingClueBoxes.isEmpty)
    }
    
    @Test func testSelectedRemainingClueBoxesSome() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 1 && allClueBoxes.selectedRemainingClueBoxes.first === clueBox1)
    }
    
    // SelectedClueBoxIDs
    @Test func testSelectedClueBoxIDsAll() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.selectedClueBoxIDs.count == 2 && allClueBoxes.selectedClueBoxIDs.contains(where: {$0 == clueBox1.getID()}) && allClueBoxes.selectedClueBoxIDs.contains(where: {$0 == clueBox2.getID()}))
    }
    
    @Test func testSelectedClueBoxIDsNone() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.selectedClueBoxIDs.count == 0)
    }
    
    @Test func testSelectedClueBoxIDsSome() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        #expect(allClueBoxes.selectedClueBoxIDs.count == 1 && allClueBoxes.selectedClueBoxIDs.contains(where: {$0 == clueBox1.getID()}) && !allClueBoxes.selectedClueBoxIDs.contains(where: {$0 == clueBox2.getID()}))
    }
    
    // SubmitIsClickable
    @Test func testSubmitIsClickableAllSelected() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox4: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3, clueBox4]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == true)
    }

    @Test func testSubmitIsClickableNoneSelected() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox4: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3, clueBox4]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == false)
    }

    @Test func testSubmitIsClickableEnoughSelected() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox4: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox5: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3, clueBox4, clueBox5]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == true)
    }
    
    @Test func testSubmitIsClickableNotEnoughSelected() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox4: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3, clueBox4]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == false)
    }
    
    @Test func testSubmitIsClickableTooManySelected() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox4: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox5: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3, clueBox4, clueBox5]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == false)
    }
    
    @Test func testSubmitIsClickableEnoughSelectedWithCompleted() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox4: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox5: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: true).build()
        let clueBox6: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: true).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3, clueBox4, clueBox5, clueBox6]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == true)
    }
    
    @Test func testSubmitIsClickableNotEnoughSelectedWithCompleted() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox4: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox5: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: true).build()
        let clueBox6: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: true).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3, clueBox4, clueBox5, clueBox6]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == false)
    }
    
    @Test func testSubmitIsClickableAllSelectedDifferentNumCluesPerCategory() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 2).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == true)
    }
    
    @Test func testSubmitIsClickableEnoughSelectedDifferentNumCluesPerCategory() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 2).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == true)
    }
    
    @Test func testSubmitIsClickableNotEnoughSelectedDifferentNumCluesPerCategory() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 2).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == false)
    }
    
    @Test func testSubmitIsClickableNoClueBoxes() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: []).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.submitIsClickable == false)
    }
    
    // DeselectAllIsClickable
    @Test func testDeselectAllIsClickableAllSelected() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3]).build()
        #expect(allClueBoxes.deselectAllIsClickable == true)
    }
    
    @Test func testDeselectAllIsClickableNoneSelected() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3]).build()
        #expect(allClueBoxes.deselectAllIsClickable == false)
    }
    
    @Test func testDeselectAllIsClickableSomeSelected() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3]).build()
        #expect(allClueBoxes.deselectAllIsClickable == true)
    }
    
    @Test func testDeselectAllIsClickableNoneSelectedWithCompleted() {
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: false).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: true).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3]).build()
        #expect(allClueBoxes.deselectAllIsClickable == false)
    }
    
    @Test func testDeselectAllIsClickableTooManySelected() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 2).build()
        let clueBox1: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let clueBox3: ClueBox = ClueBoxBuilder().withIsSelected(isSelected: true).withIsCompleted(isCompleted: false).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2, clueBox3]).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.deselectAllIsClickable == true)
    }
    
    @Test func testDeselectAllIsClickableNoClueBoxes() {
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: 4).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: []).withGameProperties(gameProperties: gameProperties).build()
        #expect(allClueBoxes.deselectAllIsClickable == false)
    }
    
    // Reset
    @Test func testCompletedReset() {
        let numCluesPerConnectionsCategory: Int = 4
        let numConnectionsCategories: Int = 4
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: numCluesPerConnectionsCategory).withNumConnectionsCategories(numConnectionsCategories: numConnectionsCategories).build()
        let allClueBoxes: AllClueBoxes = try! AllClueBoxesBuilder().withGameProperties(gameProperties: gameProperties).withCompleteAllClueBoxes().build()
        allClueBoxes.reset()

        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 0)
        #expect(allClueBoxes.remainingClueBoxes.count == numCluesPerConnectionsCategory * numConnectionsCategories)
        #expect(allClueBoxes.selectedRemainingClueBoxes.isEmpty)
        #expect(allClueBoxes.selectedClueBoxIDs.isEmpty)
        #expect(allClueBoxes.submitIsClickable == false)
        #expect(allClueBoxes.deselectAllIsClickable == false)
    }

    @Test func testPartiallyCompletedReset() {
        let numCluesPerConnectionsCategory: Int = 4
        let numConnectionsCategories: Int = 4
        let numClueBoxes: Int = numCluesPerConnectionsCategory * numConnectionsCategories
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: numCluesPerConnectionsCategory).withNumConnectionsCategories(numConnectionsCategories: numConnectionsCategories).build()
        let allClueBoxes: AllClueBoxes = try! AllClueBoxesBuilder().withGameProperties(gameProperties: gameProperties).withNCompletedClueBoxes(n: numClueBoxes / 2).build()
        allClueBoxes.reset()

        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 0)
        #expect(allClueBoxes.remainingClueBoxes.count == numClueBoxes)
        #expect(allClueBoxes.selectedRemainingClueBoxes.isEmpty)
        #expect(allClueBoxes.selectedClueBoxIDs.isEmpty)
        #expect(allClueBoxes.submitIsClickable == false)
        #expect(allClueBoxes.deselectAllIsClickable == false)
    }
    
    @Test func testFreshReset() {
        let numCluesPerConnectionsCategory: Int = 4
        let numConnectionsCategories: Int = 4
        let numClueBoxes: Int = numCluesPerConnectionsCategory * numConnectionsCategories
        let gameProperties: GameProperties = GamePropertiesBuilder().withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: numCluesPerConnectionsCategory).withNumConnectionsCategories(numConnectionsCategories: numConnectionsCategories).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withGameProperties(gameProperties: gameProperties).build()
        allClueBoxes.reset()

        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 0)
        #expect(allClueBoxes.remainingClueBoxes.count == numClueBoxes)
        #expect(allClueBoxes.selectedRemainingClueBoxes.isEmpty)
        #expect(allClueBoxes.selectedClueBoxIDs.isEmpty)
        #expect(allClueBoxes.submitIsClickable == false)
        #expect(allClueBoxes.deselectAllIsClickable == false)
    }
    
    // Click ClueBox
    @Test func testClickUnselectedClueBoxNoneSelected() throws {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        let gameProperties: GameProperties = GameProperties(setupInfo: setupInfo)
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder(setupInfo: setupInfo).withGameProperties(gameProperties: gameProperties).build()
        let clueBox: ClueBox = try #require(allClueBoxes.allClueBoxes.first, "There needs to be a ClueBox to click")
        allClueBoxes.clickClueBox(clueBox: clueBox)
        #expect(clueBox.isSelected == true)
    }
    
    @Test func testClickUnselectedClueBoxSomeSelected() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        let gameProperties: GameProperties = GameProperties(setupInfo: setupInfo)
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder(setupInfo: setupInfo).withGameProperties(gameProperties: gameProperties).build()
        let clueBoxes: ArraySlice<ClueBox> = allClueBoxes.allClueBoxes[0...gameProperties.numCluesPerConnectionsCategory - 2]
        clueBoxes.forEach({clueBox in
            clueBox.select()
        })
        let clueBoxToClick: ClueBox = allClueBoxes.allClueBoxes[gameProperties.numCluesPerConnectionsCategory]
        allClueBoxes.clickClueBox(clueBox: clueBoxToClick)
        #expect(clueBoxToClick.isSelected == true)
    }

    @Test func testClickUnselectedClueBoxFullConnectionsCategorySelected() {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        let gameProperties: GameProperties = GameProperties(setupInfo: setupInfo)
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder(setupInfo: setupInfo).withGameProperties(gameProperties: gameProperties).build()
        let clueBoxes: ArraySlice<ClueBox> = allClueBoxes.allClueBoxes[0...gameProperties.numCluesPerConnectionsCategory - 1]
        clueBoxes.forEach({clueBox in
            clueBox.select()
        })
        let clueBoxToClick: ClueBox = allClueBoxes.allClueBoxes[gameProperties.numCluesPerConnectionsCategory]
        allClueBoxes.clickClueBox(clueBox: clueBoxToClick)
        #expect(clueBoxToClick.isSelected == false)
    }

    @Test func testClickSelectedClueBoxOnlyOneSelected() throws {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        let gameProperties: GameProperties = GameProperties(setupInfo: setupInfo)
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder(setupInfo: setupInfo).withGameProperties(gameProperties: gameProperties).build()
        let clueBox: ClueBox = try #require(allClueBoxes.allClueBoxes.first, "There needs to be a ClueBox to click")
        clueBox.select()
        allClueBoxes.clickClueBox(clueBox: clueBox)
        #expect(clueBox.isSelected == false)
    }
    
    @Test func testClickSelectedClueBoxFullConnectionsCategorySelected() throws {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        let gameProperties: GameProperties = GameProperties(setupInfo: setupInfo)
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder(setupInfo: setupInfo).withGameProperties(gameProperties: gameProperties).build()
        let clueBoxes: ArraySlice<ClueBox> = allClueBoxes.allClueBoxes[0...gameProperties.numCluesPerConnectionsCategory - 1]
        clueBoxes.forEach({clueBox in
            clueBox.select()
        })
        let clueBoxToClick: ClueBox = try #require(clueBoxes.first)
        allClueBoxes.clickClueBox(clueBox: clueBoxToClick)
        #expect(clueBoxToClick.isSelected == false)
    }
    
    // Shuffle
    @Test func testShuffleAllClueBoxesRemaining() {
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().build()
        let originalClueBoxes: [ClueBox] = allClueBoxes.allClueBoxes
        allClueBoxes.shuffleClueBoxes()
        #expect(originalClueBoxes.sorted() == allClueBoxes.allClueBoxes.sorted() && originalClueBoxes != allClueBoxes.allClueBoxes)
    }

    @Test func testShuffleSomeClueBoxesRemaining() throws {
        let allClueBoxes: AllClueBoxes = try! AllClueBoxesBuilder().withNCompletedClueBoxes(n: 4).build()
        let originalClueBoxes: [ClueBox] = allClueBoxes.remainingClueBoxes
        allClueBoxes.shuffleClueBoxes()
        #expect(originalClueBoxes.sorted() == allClueBoxes.remainingClueBoxes.sorted() && originalClueBoxes != allClueBoxes.remainingClueBoxes)
    }
    
    @Test func testShuffleNoClueBoxesRemaining() throws {
        let allClueBoxes: AllClueBoxes = try! AllClueBoxesBuilder().withCompleteAllClueBoxes().build()
        let originalClueBoxes: [ClueBox] = allClueBoxes.remainingClueBoxes
        allClueBoxes.shuffleClueBoxes()
        #expect(originalClueBoxes.sorted() == allClueBoxes.remainingClueBoxes.sorted() && originalClueBoxes == allClueBoxes.remainingClueBoxes)
    }
    
    @Test func testShuffleAllClueBoxesRemainingOneSelected() throws {
        let setupInfo: SetupInfo = createDefaultTestSetupInfo()
        let gameProperties: GameProperties = GameProperties(setupInfo: setupInfo)
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder(setupInfo: setupInfo).withGameProperties(gameProperties: gameProperties).build()
        let clueBox: ClueBox = try #require(allClueBoxes.allClueBoxes.first, "There needs to be a ClueBox to click")
        clueBox.select()
        let originalClueBoxes: [ClueBox] = allClueBoxes.remainingClueBoxes
        allClueBoxes.shuffleClueBoxes()
        #expect(originalClueBoxes.sorted() == allClueBoxes.allClueBoxes.sorted() && originalClueBoxes != allClueBoxes.allClueBoxes && allClueBoxes.selectedRemainingClueBoxes == [clueBox])
    }
    
    // Deselect all
    @Test func testDeselectAllNoneSelected() {
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().build()
        allClueBoxes.deselectAllClueBoxes()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 0)
    }
    
    @Test func testDeselectAllSomeSelected() {
        let allClueBoxes: AllClueBoxes = try! AllClueBoxesBuilder().withNSelectedClueBoxes(n: 2).build()
        allClueBoxes.deselectAllClueBoxes()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 0)
    }
    
    @Test func testDeselectAllAllSelected() {
        let allClueBoxes: AllClueBoxes = try! AllClueBoxesBuilder().withSelectAllClueBoxes().build()
        allClueBoxes.deselectAllClueBoxes()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 0)
    }
    
    @Test func testDeselectAllSomeSelectedSomeCompleted() {
        let allClueBoxes: AllClueBoxes = try! AllClueBoxesBuilder().withNCompletedClueBoxes(n: 2).withNSelectedClueBoxes(n: 4).build()
        allClueBoxes.deselectAllClueBoxes()
        #expect(allClueBoxes.numSelectedRemainingClueBoxes == 0 && allClueBoxes.allClueBoxes.allSatisfy({clueBox in
            clueBox.isSelected == false
        }))
    }
    
    // Complete Connections Category
    @Test func testCompleteConnectionsCategory() {
        let categoryID1: UUID = UUID()
        let categoryID2: UUID = UUID()
        let clueBox1: ClueBox = ClueBoxBuilder().withClueInfo(clueInfo: ClueInfo(clue: "Clueee", connectionsCategoryID: categoryID1)).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withClueInfo(clueInfo: ClueInfo(clue: "Hmm", connectionsCategoryID: categoryID2)).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        try! allClueBoxes.completeClueBoxesByConnectionsCategoryID(connectionsCategoryID: categoryID1)
        #expect(allClueBoxes.numRemainingClueBoxes == 1 && allClueBoxes.remainingClueBoxes.first! === clueBox2)
    }

    @Test func testCompleteUnknownConnectionsCategory() {
        let categoryID: UUID = UUID()
        let clueBox: ClueBox = ClueBoxBuilder().withClueInfo(clueInfo: ClueInfo(clue: "Clueee", connectionsCategoryID: categoryID)).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox]).build()
        #expect(throws: ValidationError.unknownConnectionsCategoryID) {
            try allClueBoxes.completeClueBoxesByConnectionsCategoryID(connectionsCategoryID: categoryID)
        }
        #expect(allClueBoxes.numRemainingClueBoxes == 1 && allClueBoxes.remainingClueBoxes.first! === clueBox)
    }
    
    @Test func testCompleteCompletedConnectionsCategory() {
        let categoryID1: UUID = UUID()
        let categoryID2: UUID = UUID()
        let clueBox1: ClueBox = ClueBoxBuilder().withClueInfo(clueInfo: ClueInfo(clue: "Clueee", connectionsCategoryID: categoryID1)).withIsCompleted(isCompleted: true).build()
        let clueBox2: ClueBox = ClueBoxBuilder().withClueInfo(clueInfo: ClueInfo(clue: "Hmm", connectionsCategoryID: categoryID2)).build()
        let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().withAllClueBoxes(allClueBoxes: [clueBox1, clueBox2]).build()
        try! allClueBoxes.completeClueBoxesByConnectionsCategoryID(connectionsCategoryID: categoryID1)
        #expect(allClueBoxes.numRemainingClueBoxes == 1 && allClueBoxes.remainingClueBoxes.first! === clueBox2)
    }
}
