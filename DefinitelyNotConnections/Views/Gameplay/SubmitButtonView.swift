//
//  Submit.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct SubmitButtonView: View {
    @Bindable var mainGame: MainGame
    
    var body: some View {
        Button {
            if mainGame.gameGrid.remainingClueBoxes.isSubmitClickable() {
                mainGame.submitSelection()
            }
        } label: {
            GameplayButtonView(text: "Submit", isClickable: mainGame.gameGrid.remainingClueBoxes.isSubmitClickable())
                .alert(Text("Oh go on then, have another go!"), isPresented: $mainGame.noMistakesLeft) {
                    Button("Ok") {
                        mainGame.resetNumMistakesRemaining()
                    }
                }
        }
    }
}

/*
#Preview {
    @State var model: ConnectionsGameModel = ConnectionsGameModel()
    SubmitButton(connectionsGameModel: $model)
}
*/
