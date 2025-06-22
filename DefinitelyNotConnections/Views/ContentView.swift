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
        VStack {
            OneAway()
                .show(for: .seconds(2), trigger: connectionsGameModel.oneAway)
            Text("Create four groups of four!")
                .foregroundStyle(.foreground)
            ClueBoxGrid()
                .padding(.horizontal)
            MistakesRemaining()
            HStack {
                ShuffleButton()
                DeselectAllButton()
                SubmitButton()
            }
        }
    }
}


#Preview {
    let connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    ContentView()
        .environment(connectionsGameModel)
}

