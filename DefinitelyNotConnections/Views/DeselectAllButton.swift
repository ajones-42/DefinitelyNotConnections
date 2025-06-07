//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButton: View {
    // @Environment(ConnectionsGameViewModel.self) private var connectionsGameViewModel: ConnectionsGameViewModel
    let connectionsGameViewModel: ConnectionsGameViewModel
    
    var body: some View {
        Button {
            connectionsGameViewModel.clickDeselectAll()
        } label: {
            NormalButton(text: "Deselect All", boxColour: connectionsGameViewModel.deselectAllBoxColour, textColour: connectionsGameViewModel.deselectAllTextColour)
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
