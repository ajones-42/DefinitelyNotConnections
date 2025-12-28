//
//  AdmiringPuzzleView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import SwiftUI

struct AdmiringPuzzleScreen: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                GuessesButtonView()
            }
            Spacer()
            Text("Obvio!")
                .foregroundStyle(.foreground)
                .font(.largeTitle)
                .fontWeight(.heavy)
            GameGridView()
                .padding(.horizontal)
            Button {
                connectionsGameModel.finishPlaying()
            } label: {
                AppNavigationButton(text: "Finish", boxColour: Color(UIColor.systemGray), textColour: .white)
            }
            Button {
                connectionsGameModel.resetGame()
            } label: {
                AppNavigationButton(text: "Play again", boxColour: Color(UIColor.systemGray), textColour: .white)
            }
            Spacer()
        }
    }
}

/*#Preview {
    let connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    AdmiringPuzzleScreen()
        .environment(connectionsGameModel)
}*/
