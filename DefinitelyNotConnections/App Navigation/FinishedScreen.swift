//
//  FinishedScreen.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 26.06.25.
//

import SwiftUI

struct FinishedScreen: View {
    @Environment(MainGame.self) private var mainGame: MainGame

    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            VStack {
                Text("YOU DID IT AGAIN!")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Happy anniversary! I love you!")
                    .foregroundStyle(.black)
                    .font(.title3)
                
            Button {
                mainGame.admirePuzzle()
            } label: {
                AppNavigationButton(text: "Admire puzzle", boxColour: .black, textColour: .white)
            }
                Button {
                    mainGame.resetGame()
                } label: {
                    AppNavigationButton(text: "Play again", boxColour: .black, textColour: .white)
                }
            }
        }
    }
}

#Preview {
    let setupInfo: SetupInfo = createDefaultTestSetupInfo()
    let mainGame: MainGame = MainGameBuilder(setupInfo: setupInfo).build()
    FinishedScreen()
        .environment(mainGame)
}
