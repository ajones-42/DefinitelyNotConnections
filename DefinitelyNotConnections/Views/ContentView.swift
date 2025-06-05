//
//  ContentView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ContentView: View {
    @State private var connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    var body: some View {
        VStack {
            Text("Create four groups of four!")
                .foregroundStyle(.black)
            ClueBoxGrid(connectionsGameModel: $connectionsGameModel)
                .padding(.horizontal)
            MistakesRemaining(connectionsGameModel: $connectionsGameModel)
            HStack {
                DeselectAllButton(connectionsGameModel: $connectionsGameModel)
                SubmitButton(connectionsGameModel: $connectionsGameModel)
            }
        }
    }
}


#Preview {
    ContentView()
}

