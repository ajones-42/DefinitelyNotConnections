//
//  AdmiringPuzzleView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import SwiftUI

struct AdmiringPuzzleScreen: View {
    @Environment(MainGame.self) private var mainGame: MainGame
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                GuessesButtonView(allGuesses: mainGame.allGuesses)
            }
            Spacer()
            Text("Obvio!")
                .foregroundStyle(.foreground)
                .font(.largeTitle)
                .fontWeight(.heavy)
            CategoriesView()
                .padding(.horizontal)
            Button {
                mainGame.finishPlaying()
            } label: {
                AppNavigationButton(text: "Finish", boxColour: Color(UIColor.systemGray), textColour: .white)
            }
            Button {
                mainGame.resetGame()
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
