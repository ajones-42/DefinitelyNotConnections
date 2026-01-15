//
//  DefinitelyNotConnectionsApp.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

@main
struct DefinitelyNotConnectionsApp: App {
    @State private var mainGame: MainGame = MainGame(gameProperties: GameProperties(), categoryInfos: createDefaultTestCategoryInfos())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(mainGame)
        }
    }
}
