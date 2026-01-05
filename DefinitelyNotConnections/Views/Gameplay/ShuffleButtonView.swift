//
//  ShuffleButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct ShuffleButtonView: View {
    @Environment(RemainingClueBoxes.self) private var remainingClueBoxes: RemainingClueBoxes
    
    var body: some View {
        Button {
            // No check since shuffle is always clickable
            remainingClueBoxes.shuffleClueBoxes()
        } label: {
            GameplayButtonView(text: "Shuffle", isClickable: true)
        }
    }
}

/*
#Preview {
    ShuffleButton()
}
*/
