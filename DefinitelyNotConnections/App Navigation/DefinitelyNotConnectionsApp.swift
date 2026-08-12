//
//  DefinitelyNotConnectionsApp.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

@main
struct DefinitelyNotConnectionsApp: App {
    @State private var mainGame: MainGame = MainGame(setupInfo: createRealSetupInfo(year: 2))
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(mainGame)
        }
    }
}
