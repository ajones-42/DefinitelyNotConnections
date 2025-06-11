//
//  Submit.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct SubmitButton: View {
    //@Environment(ConnectionsGameViewModel.self) private var connectionsGameViewModel: ConnectionsGameViewModel
    let connectionsGameViewModel: ConnectionsGameViewModel
    @State var showAlert: Bool = false
    
    var body: some View {
        Button {
            connectionsGameViewModel.clickSubmit()
            if connectionsGameViewModel.numMistakesRemaining == 0 {
                showAlert = true
            }
        } label: {
            NormalButton(text: "Submit", boxColour: connectionsGameViewModel.submitBoxColour, textColour: connectionsGameViewModel.submitTextColour)
                .alert(Text("Oh go on then, have another go!"), isPresented: $showAlert) {
                    Button("Ok") {
                        connectionsGameViewModel.resetNumMistakesRemaining()
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
