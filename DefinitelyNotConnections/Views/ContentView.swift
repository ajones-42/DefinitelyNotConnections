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
        switch connectionsGameModel.getCurrentGamePhase() {
        case .setup:
            StartScreen()
                .environment(connectionsGameModel.mainGame)
        case .playing:
            GameplayScreen()
        case .finished:
            FinishedScreen()
                .environment(connectionsGameModel.mainGame)
        case .admiring:
            AdmiringPuzzleScreen()
                .environment(connectionsGameModel.mainGame)
        }
    }
}


#Preview {
    let connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    ContentView()
        .environment(connectionsGameModel)
}

