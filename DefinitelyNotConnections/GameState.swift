//
//  GameState.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import Foundation

struct GameState {
    private var gamePhase: GamePhase
    
    private var numMistakesRemaining: Int
    // Can't compute self.completedCategories since the order completed categories are shown in will change
    private var completedCategories: [Category] {
        didSet {
            if completedCategories.count == 4 {
                finishedPlaying()
            }
        }
    }
    
    private var guesses: [Guess]
    
    private var remainingClueBoxes: [ClueBox]
    private var selectedClueBoxes: [ClueBox] {
        self.remainingClueBoxes.filter { $0.isSelected }
    }
    private var numSelectedClueBoxes: Int {
        self.selectedClueBoxes.count
    }
    private var unselectedBoxesAreClickable: Bool {
        self.numSelectedClueBoxes < 4
    }
    private var deselectAllIsClickable: Bool {
        self.numSelectedClueBoxes > 0
    }
    
    private let shuffleIsClickable: Bool = true // Always clickable
    private var submitIsClickable: Bool {
        self.numSelectedClueBoxes == 4
    }


    
    init(clueBoxes: [ClueBox]) {
        self.gamePhase = .setup
        self.completedCategories = []
        self.guesses = []
        self.remainingClueBoxes = clueBoxes
        self.numMistakesRemaining = 4
        deselectAllClueBoxes()
    }
    
    mutating func startPlaying() {
        self.gamePhase = .playing
    }
    
    mutating func finishedPlaying() {
        self.gamePhase = .finished
    }
    
    mutating func admirePuzzle() {
        self.gamePhase = .admiring
    }
    
    func getCurrentGamePhase() -> GamePhase {
        return self.gamePhase
    }
    
    mutating func completeCategory(category: Category) {
        self.completedCategories.append(category)
    }
    
    func getCompletedCategories() -> [Category] {
        return self.completedCategories
    }
    
    mutating func addGuess(guess: Guess) {
        self.guesses.append(guess)
    }
    
    func getGuesses() -> [Guess] {
        return self.guesses
    }
    
    func getNumGuesses() -> Int {
        return self.guesses.count
    }
    
    func getRemainingClueBoxes() -> [ClueBox] {
        return self.remainingClueBoxes
    }
    
    func getSelectedClueBoxes() -> [ClueBox] {
        return self.selectedClueBoxes
    }
    
    mutating func removeSelectedClueBoxes() {
        self.remainingClueBoxes.removeAll(where: { $0.isSelected })
    }
    
    func isShuffleClickable() -> Bool {
        return self.shuffleIsClickable
    }
    
    mutating func shuffleClueBoxes() {
        self.remainingClueBoxes.shuffle()
    }
    
    func deselectAllClueBoxes() {
        for clueBox in self.remainingClueBoxes {
            clueBox.deselect()
        }
    }
    
    func areUnselectedClueBoxesClickable() -> Bool {
        return self.unselectedBoxesAreClickable
    }
    
    // These might need to be removed to allow for observation
    func isDeselectAllClickable() -> Bool {
        return self.deselectAllIsClickable
    }
    
    func isSubmitClickable() -> Bool {
        return self.submitIsClickable
    }
    
    func getNumMistakesRemaining() -> Int {
        return self.numMistakesRemaining
    }
    
    mutating func madeMistake() {
        self.numMistakesRemaining -= 1
    }
    
    mutating func resetNumMistakesRemaining() {
        self.numMistakesRemaining = 4
    }
    
    /*
    func getClueBoxIndex(clueBoxID: Int) -> Int? {
        return self.remainingClueBoxes.firstIndex(where: { $0.id == clueBoxID })
    }
    
    func getClueBox(clueBox: ClueBox) -> ClueBox? {
        if let boxIndex = getClueBoxIndex(clueBoxID: clueBox.id) {
            return self.remainingClueBoxes[boxIndex]
        } else {
            return nil
        }
    }
    
    func clueBoxIsClickable(clueBox: ClueBox) -> Bool {
        return (self.numSelectedBoxes < 4 || clueBox.isSelected)
    }
    */
}
