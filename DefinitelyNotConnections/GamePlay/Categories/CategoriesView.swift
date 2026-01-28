//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct CategoriesView: View {
    let categories: Categories
    
    var body: some View {
        VStack {
            CompletedCategoriesView(categories: categories)
            RemainingClueBoxesView()
        }
    }
}

#Preview {
    let setupInfo: SetupInfo = createDefaultTestSetupInfo()
    let mainGame: MainGame = MainGameBuilder(setupInfo: setupInfo).build()
    CategoriesView(categories: mainGame.categories)
        .environment(mainGame)
}
