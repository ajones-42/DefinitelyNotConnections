//
//  GamePlayView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import SwiftUI

struct GameplayScreen: View {
    @Environment(MainGame.self) private var mainGame: MainGame

    var body: some View {
        VStack {
            HStack {
                Spacer()
                GuessesButtonView(allGuesses: mainGame.allGuesses)
            }
            Spacer()
            MainGameView()
            Spacer()
        }
    }
}

/*#Preview {
    let connectionsGameModel: ConnectionsGameModel = ConnectionsGameModel()
    GamePlayScreen()
        .environment(connectionsGameModel)
}
*/
