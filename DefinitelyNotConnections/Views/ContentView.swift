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
            Text("Create four groups of four!")
                .foregroundStyle(.black)
            ClueBoxGrid(connectionsGameViewModel: connectionsGameViewModel)
                .padding(.horizontal)
            MistakesRemaining(connectionsGameViewModel: connectionsGameViewModel)
            HStack {
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

