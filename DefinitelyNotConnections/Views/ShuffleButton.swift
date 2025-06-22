//
//  ShuffleButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct ShuffleButton: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        Button {
            connectionsGameModel.shuffleClueBoxes()
        } label: {
            NormalButton(text: "Shuffle", boxColour: Color(UIColor.systemGray), textColour: .white)
        }
    }
}

/*
#Preview {
    ShuffleButton()
}
*/
