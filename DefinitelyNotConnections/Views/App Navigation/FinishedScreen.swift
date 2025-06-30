//
//  FinishedScreen.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 26.06.25.
//

import SwiftUI

struct FinishedScreen: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel

    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            VStack {
                Text("YOU DID IT!")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Happy anniversary! I love you!")
                    .foregroundStyle(.black)
                    .font(.title3)
                
            Button {
                connectionsGameModel.admirePuzzle()
            } label: {
                AppNavigationButton(text: "Admire puzzle", boxColour: .black, textColour: .white)
            }
                Button {
                    connectionsGameModel.resetGame()
                } label: {
                    AppNavigationButton(text: "Play again", boxColour: .black, textColour: .white)
                }
            }
        }
    }
}

#Preview {
    FinishedScreen()
}
