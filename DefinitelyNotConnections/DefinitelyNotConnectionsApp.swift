//
//  DefinitelyNotConnectionsApp.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

@main
struct DefinitelyNotConnectionsApp: App {
    let connectionsGameViewModel: ConnectionsGameViewModel = ConnectionsGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(connectionsGameViewModel: connectionsGameViewModel)
        }
    }
}
