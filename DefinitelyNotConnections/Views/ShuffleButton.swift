//
//  ShuffleButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct ShuffleButton: View {
    //@Environment(ConnectionsGameViewModel.self) private var connectionsGameViewModel: ConnectionsGameViewModel
    let connectionsGameViewModel: ConnectionsGameViewModel
    
    var body: some View {
        Button {
            connectionsGameViewModel.clickShuffle()
        } label: {
            NormalButton(text: "Shuffle", boxColour: .black, textColour: .white)
        }
    }
}

/*
#Preview {
    ShuffleButton()
}
*/
