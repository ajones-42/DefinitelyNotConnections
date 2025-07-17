//
//  ShuffleButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct ShuffleButtonView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        Button {
            connectionsGameModel.shuffleClueBoxes()
        } label: {
            GameplayButtonView(text: "Shuffle", isClickable: connectionsGameModel.isShuffleClickable())
        }
    }
}

/*
#Preview {
    ShuffleButton()
}
*/
