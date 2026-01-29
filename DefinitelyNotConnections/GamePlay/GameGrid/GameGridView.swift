//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct GameGridView: View {
    let gameGrid: GameGrid
    
    var body: some View {
        VStack {
            CompletedCategoriesView(categories: gameGrid) //TODO Give only Categories
            RemainingClueBoxesView(allClueBoxes: gameGrid.allClueBoxes)
        }
    }
}

#Preview {
    let gameGrid: GameGrid = GameGridBuilder().build()
    GameGridView(gameGrid: gameGrid)
}
