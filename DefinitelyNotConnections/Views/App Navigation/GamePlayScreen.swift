//
//  GamePlayView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import SwiftUI

struct GamePlayScreen: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel

    var body: some View {
        VStack {
            Popup(text: connectionsGameModel.popupText)
                .show(for: .seconds(2), trigger: connectionsGameModel.popupTrigger)
            Text("Create four groups of four!")
                .foregroundStyle(.foreground)
            ClueBoxGrid()
                .padding(.horizontal)
            MistakesRemaining()
            HStack {
                ShuffleButton()
                DeselectAllButton()
                SubmitButton()
            }
        }
    }
}

/*#Preview {
    let connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    GamePlayScreen()
        .environment(connectionsGameModel)
}
*/
