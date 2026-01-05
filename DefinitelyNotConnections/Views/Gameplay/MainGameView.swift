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
            GameGridView()
                .padding(.horizontal)
            MistakesRemainingView()
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
