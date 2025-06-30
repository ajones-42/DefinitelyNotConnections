//
//  ContentView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ContentView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel

    var body: some View {
        switch connectionsGameModel.gameState.gamePhase {
        case .setup:
            StartScreen()
        case .playing:
            GamePlayScreen()
        case .finished:
            FinishedScreen()
        }
    }
}


#Preview {
    let connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    ContentView()
        .environment(connectionsGameModel)
}

