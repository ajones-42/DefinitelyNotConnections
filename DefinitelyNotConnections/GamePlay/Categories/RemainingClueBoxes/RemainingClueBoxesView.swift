//
//  RemainingClueBoxes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct RemainingClueBoxesView: View {
    @Environment(MainGame.self) private var mainGame: MainGame

    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
            ForEach(mainGame.categories.allClueBoxes.remainingClueBoxes, id: \.clueInfo.id) { clueBox in
                ClueBoxView(clueBox: clueBox)
                    .onTapGesture {
                        mainGame.clickClueBox(clueBox: clueBox)
                    }
            }
        }
    }
}

//#Preview {
    //RemainingClueBoxesView()
//}
