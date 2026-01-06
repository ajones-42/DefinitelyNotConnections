//
//  GameView.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct MainGameView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel

    var body: some View {
        VStack {
            PopupView()
                .environment(connectionsGameModel.popup)
            Text("Create four groups of four!")
                .foregroundStyle(.foreground)
            GameGridView()
                .padding(.horizontal)
                .environment(connectionsGameModel.mainGame.gameGrid)
            MistakesRemainingView()
                .environment(connectionsGameModel.mainGame)
            HStack {
                ShuffleButtonView()
                    .environment(connectionsGameModel.mainGame.gameGrid.remainingClueBoxes)
                DeselectAllButtonView()
                    .environment(connectionsGameModel.mainGame.gameGrid.remainingClueBoxes)
                SubmitButtonView()
            }
        }
    }
}
