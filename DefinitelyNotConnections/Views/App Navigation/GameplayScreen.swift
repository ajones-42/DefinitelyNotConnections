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
            }
            Spacer()
            PopupView(text: connectionsGameModel.popupText)
                .show(for: .seconds(2), trigger: connectionsGameModel.popupTrigger)
            Text("Create four groups of four!")
                .foregroundStyle(.foreground)
            GameGridView()
                .padding(.horizontal)
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
