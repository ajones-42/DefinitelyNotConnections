//
//  GameView.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct GameView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel

    var body: some View {
        VStack {
            GameGridView()
                .padding(.horizontal)
            MistakesRemainingView()
            HStack {
                ShuffleButtonView()
                    .environment(connectionsGameModel.gameGrid.remainingClueBoxes)
                DeselectAllButtonView()
                SubmitButtonView()
            }
        }
    }
}
