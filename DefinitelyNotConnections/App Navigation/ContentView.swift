//
//  ContentView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ContentView: View {
    @Environment(MainGame.self) private var mainGame: MainGame

    var body: some View {
        switch mainGame.gamePhase {
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
 let setupInfo: SetupInfo = createDefaultTestSetupInfo()
 let mainGame: MainGame = MainGameBuilder(setupInfo: setupInfo).build()
    ContentView()
        .environment(mainGame)
}

