//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButtonView: View {
    @Environment(RemainingClueBoxes.self) private var remainingClueBoxes: RemainingClueBoxes
    
    var body: some View {
        Button {
            if remainingClueBoxes.isDeselectAllClickable() {
                remainingClueBoxes.deselectAllClueBoxes()
            }
        } label: {
            GameplayButtonView(text: "Deselect All", isClickable: remainingClueBoxes.isDeselectAllClickable())
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
