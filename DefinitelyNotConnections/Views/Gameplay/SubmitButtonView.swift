//
//  Submit.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct SubmitButtonView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    @State var showAlert: Bool = false
    
    var body: some View {
        Button {
            if connectionsGameModel.mainGame.gameGrid.remainingClueBoxes.isSubmitClickable() {
                connectionsGameModel.mainGame.submitSelection()
                if connectionsGameModel.mainGame.getNumMistakesRemaining() == 0 {
                    showAlert = true
                }
            }
        } label: {
            GameplayButtonView(text: "Submit", isClickable: connectionsGameModel.mainGame.gameGrid.remainingClueBoxes.isSubmitClickable())
                .alert(Text("Oh go on then, have another go!"), isPresented: $showAlert) {
                    Button("Ok") {
                        connectionsGameModel.mainGame.resetNumMistakesRemaining()
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
