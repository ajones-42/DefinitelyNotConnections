//
//  RemainingClueBoxes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct RemainingClueBoxesView: View {
    let allClueBoxes: AllClueBoxes

    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
            ForEach(allClueBoxes.remainingClueBoxes, id: \.clueInfo.id) { clueBox in
                ClueBoxView(clueBox: clueBox)
                    .onTapGesture {
                        allClueBoxes.clickClueBox(clueBox: clueBox)
                    }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().build()
    RemainingClueBoxesView(allClueBoxes: allClueBoxes)
}
