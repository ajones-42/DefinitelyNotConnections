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
            GameGridView()
                .padding(.horizontal)
                .overlay(OutOfMistakesAlertView())
            MistakesRemainingView(mistakes: mainGame.mistakes)
            HStack {
                ShuffleButtonView()
                DeselectAllButtonView(remainingClueBoxes: mainGame.gameGrid.remainingClueBoxes)
                SubmitButtonView()
            }
        }
    }
}
