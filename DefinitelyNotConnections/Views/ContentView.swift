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
        case .playing:
            GameplayScreen()
        case .finished:
            FinishedScreen()
        case .admiring:
            AdmiringPuzzleScreen()
        }
    }
}


#Preview {
    let connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    ContentView()
        .environment(connectionsGameModel)
}

