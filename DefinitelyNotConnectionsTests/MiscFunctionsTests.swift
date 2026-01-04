//
//  MiscFunctionsTests.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 04.01.26.
//

import Testing
@testable import DefinitelyNotConnections

@Test func getAllClueBoxesTest() {
    let clueBox0: ClueBox = ClueBoxBuilder().withID(id: 0).withText(text: "Zero").build()
    let clueBox1: ClueBox = ClueBoxBuilder().withID(id: 1).withText(text: "One").build()
    let clueBox2: ClueBox = ClueBoxBuilder().withID(id: 2).withText(text: "Two").build()
    let clueBox3: ClueBox = ClueBoxBuilder().withID(id: 3).withText(text: "Three").build()
    let categories: [Category] = [CategoryBuilder().withClueBoxes(clueBoxes: [clueBox0, clueBox1]).build(), CategoryBuilder().withClueBoxes(clueBoxes: [clueBox2, clueBox3]).build()]
    let clueBoxes: [ClueBox] = getAllClueBoxes(categories: categories)
    #expect(clueBoxes == [clueBox0, clueBox1, clueBox2, clueBox3])
    
}
