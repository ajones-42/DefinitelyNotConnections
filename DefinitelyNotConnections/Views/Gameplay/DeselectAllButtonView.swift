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
            connectionsGameModel.deselectAll()
        } label: {
            GameplayButtonView(text: "Deselect All", isClickable: connectionsGameModel.deselectAllIsClickable)
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
