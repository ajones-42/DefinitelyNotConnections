//
//  GameGridView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct GameGridView: View {
    let gameGrid: GameGrid
    
    var body: some View {
        VStack {
            CompletedConnectionsCategoriesView(connectionsCategories: gameGrid.allConnectionsCategories)
            RemainingClueBoxesView(allClueBoxes: gameGrid.allClueBoxes)
        }
    }
}

#Preview {
    let gameGrid: GameGrid = try! GameGridBuilder().withNCompletedConnectionsCategories(n: 2).build()
    GameGridView(gameGrid: gameGrid)
}
