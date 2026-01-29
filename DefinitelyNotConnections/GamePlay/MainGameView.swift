//
//  GameView.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct MainGameView: View {
    @Environment(MainGame.self) private var mainGame: MainGame

    var body: some View {
        VStack {
            PopupView(popup: mainGame.popup)
            Text("Create four groups of four!")
                .foregroundStyle(.foreground)
            GameGridView(gameGrid: mainGame.gameGrid)
                .padding(.horizontal)
                .overlay(OutOfMistakesAlertView(mistakes: mainGame.mistakes))
            MistakesRemainingView(mistakes: mainGame.mistakes)
            HStack {
                ShuffleButtonView(allClueBoxes: mainGame.gameGrid.allClueBoxes)
                DeselectAllButtonView(allClueBoxes: mainGame.gameGrid.allClueBoxes)
                SubmitButtonView()
            }
        }
    }
}

#Preview {
    let setupInfo: SetupInfo = createDefaultTestSetupInfo()
    let mainGame: MainGame = MainGameBuilder(setupInfo: setupInfo).build()
    MainGameView()
        .environment(mainGame)
}
