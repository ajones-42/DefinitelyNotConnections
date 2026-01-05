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
            ForEach(gameGrid.getCompletedCategories()) { category in
                CompletedCategoryView(category: category)
            }
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                ForEach(gameGrid.getRemainingClueBoxes()) { clueBox in
                    ClueBoxView(clueBox: clueBox)
                        .onTapGesture {
                            gameGrid.remainingClueBoxes.clickClueBox(clueBox: clueBox)
                        }
                }
            }
        }
    }
}

/*
#Preview {
    ClueBoxGrid()
}
*/
