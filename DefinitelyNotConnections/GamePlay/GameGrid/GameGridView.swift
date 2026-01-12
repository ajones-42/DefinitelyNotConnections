//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct GameGridView: View {
    @Environment(MainGame.self) private var mainGame: MainGame
    
    var body: some View {
        VStack {
            CompletedCategoriesView(categories: mainGame.gameGrid.categories)
            RemainingClueBoxesView()
        }
    }
}

/*
#Preview {
    ClueBoxGrid()
}
*/
