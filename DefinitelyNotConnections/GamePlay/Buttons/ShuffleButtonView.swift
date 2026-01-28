//
//  ShuffleButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct ShuffleButtonView: View {
    let allClueBoxes: AllClueBoxes
    
    var body: some View {
        Button {
            allClueBoxes.shuffleClueBoxes()
        } label: {
            GameplayButtonView(text: "Shuffle", isClickable: true)
        }
    }
}


#Preview {
    let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().build()
    ShuffleButtonView(allClueBoxes: allClueBoxes)
}
