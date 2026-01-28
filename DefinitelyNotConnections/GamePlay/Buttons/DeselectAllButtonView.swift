//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButtonView: View {
    let allClueBoxes: AllClueBoxes
    
    var body: some View {
        Button {
            allClueBoxes.deselectAllClueBoxes()
        } label: {
            GameplayButtonView(text: "Deselect All", isClickable: allClueBoxes.deselectAllIsClickable)
        }
    }
}


#Preview {
    let allClueBoxes: AllClueBoxes = AllClueBoxesBuilder().build()
    DeselectAllButtonView(allClueBoxes: allClueBoxes)
}
