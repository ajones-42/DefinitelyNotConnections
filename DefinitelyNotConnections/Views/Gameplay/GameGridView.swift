//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct GameGridView: View {
    @Environment(GameGrid.self) private var gameGrid: GameGrid
    
    var body: some View {
        VStack {
            CompletedCategoriesView()
            RemainingClueBoxesView(remainingClueBoxes: gameGrid.remainingClueBoxes)
        }
    }
}

/*
#Preview {
    ClueBoxGrid()
}
*/
