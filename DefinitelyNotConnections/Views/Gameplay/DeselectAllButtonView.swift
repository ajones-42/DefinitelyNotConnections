//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButtonView: View {
    var remainingClueBoxes: RemainingClueBoxes
    
    var body: some View {
        Button {
            remainingClueBoxes.deselectAllClueBoxes()
        } label: {
            GameplayButtonView(text: "Deselect All", isClickable: remainingClueBoxes.deselectAllIsClickable())
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
