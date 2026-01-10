//
//  GamePlayView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 27.06.25.
//

import SwiftUI

struct GameplayScreen: View {

    var body: some View {
        VStack {
            HStack {
                Spacer()
                GuessesButtonView()
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
