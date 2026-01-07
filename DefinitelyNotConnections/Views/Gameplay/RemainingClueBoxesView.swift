//
//  RemainingClueBoxes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct RemainingClueBoxesView: View {
    var remainingClueBoxes: RemainingClueBoxes

    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
            ForEach(remainingClueBoxes.getRemainingClueBoxes()) { clueBox in
                ClueBoxView(clueBox: clueBox)
                    .onTapGesture {
                        remainingClueBoxes.clickClueBox(clueBox: clueBox)
                    }
            }
        }
    }
}

//#Preview {
    //RemainingClueBoxesView()
//}
