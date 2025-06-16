//
//  ContentView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ContentView: View {
    let connectionsGameViewModel: ConnectionsGameViewModel

    var body: some View {
        VStack {
            OneAway()
                .show(for: .seconds(2), trigger: connectionsGameViewModel.oneAway)
            Text("Create four groups of four!")
                .foregroundStyle(.foreground)
            ClueBoxGrid(connectionsGameViewModel: connectionsGameViewModel)
                .padding(.horizontal)
            MistakesRemaining(connectionsGameViewModel: connectionsGameViewModel)
            HStack {
                ShuffleButton(connectionsGameViewModel: connectionsGameViewModel)
                DeselectAllButton(connectionsGameViewModel: connectionsGameViewModel)
                SubmitButton(connectionsGameViewModel: connectionsGameViewModel)
            }
        }
    }
}


#Preview {
    let connectionsGameViewModel: ConnectionsGameViewModel = ConnectionsGameViewModel()
    ContentView(connectionsGameViewModel: connectionsGameViewModel)
}

