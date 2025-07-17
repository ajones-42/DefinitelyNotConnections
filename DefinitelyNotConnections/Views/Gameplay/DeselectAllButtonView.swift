//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButtonView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        Button {
            connectionsGameModel.deselectAllClueBoxes()
        } label: {
            GameplayButtonView(text: "Deselect All", isClickable: connectionsGameModel.isDeselectAllClickable())
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
