//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButton: View {
    // let connectionsGameViewModel: ConnectionsGameViewModel
    //@Binding var connectionsGameModel: ConnectionsGameModel
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    var boxColour: Color {
        (connectionsGameModel.numSelectedBoxes > 0) ? Color(UIColor.systemGray) : Color(UIColor.systemGray6)
    }
    var textColour: Color {
        (connectionsGameModel.numSelectedBoxes > 0) ? .white : Color(UIColor.systemGray4)
    }
    
    var body: some View {
        Button {
            connectionsGameModel.deselectAll()
        } label: {
            NormalButton(text: "Deselect All", boxColour: boxColour, textColour: textColour)
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
