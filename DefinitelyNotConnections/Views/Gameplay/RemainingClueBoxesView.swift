//
//  RemainingClueBoxes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct RemainingClueBoxesView: View {
    @Environment(GameGrid.self) private var gameGrid: GameGrid

    var body: some View {
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

//#Preview {
    //RemainingClueBoxes()
//}
