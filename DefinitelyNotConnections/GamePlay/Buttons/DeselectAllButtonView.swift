//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButtonView: View {
    @Environment(MainGame.self) private var mainGame: MainGame
    
    var body: some View {
        Button {
            mainGame.deselectAllClueBoxes()
        } label: {
            GameplayButtonView(text: "Deselect All", isClickable: mainGame.categories.remainingClueBoxes.deselectAllIsClickable)
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
