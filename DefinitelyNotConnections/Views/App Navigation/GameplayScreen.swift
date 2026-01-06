//
//  GamePlayView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import SwiftUI

struct GameplayScreen: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel

    var body: some View {
        VStack {
            HStack {
                Spacer()
                GuessesButtonView()
                    .environment(connectionsGameModel.mainGame)
            }
            Spacer()
            PopupView(text: connectionsGameModel.popup.text)
                .show(for: .seconds(2), trigger: connectionsGameModel.popup.trigger)
            Text("Create four groups of four!")
                .foregroundStyle(.foreground)
            MainGameView()
            Spacer()
        }
    }
}

/*#Preview {
    let connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    GamePlayScreen()
        .environment(connectionsGameModel)
}
*/
