//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButton: View {
    @Binding var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        Button {
            connectionsGameModel.deselectAll()
        } label: {
            NormalButton(text: "Deselect All", boxColour: connectionsGameModel.deselectAllBoxColour, textColour: connectionsGameModel.deselectAllTextColour)
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
