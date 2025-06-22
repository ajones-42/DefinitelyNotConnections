//
//  Submit.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct SubmitButton: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    @State var showAlert: Bool = false
    var boxColour: Color {
        (connectionsGameModel.numSelectedBoxes == 4) ? Color(UIColor.systemGray) : Color(UIColor.systemGray6)
    }
    var textColour: Color {
        (connectionsGameModel.numSelectedBoxes == 4) ? .white : Color(UIColor.systemGray4)
    }
    
    var body: some View {
        Button {
            connectionsGameModel.submitSelection()
            if connectionsGameModel.numMistakesRemaining == 0 {
                showAlert = true
            }
        } label: {
            NormalButton(text: "Submit", boxColour: boxColour, textColour: textColour)
                .alert(Text("Oh go on then, have another go!"), isPresented: $showAlert) {
                    Button("Ok") {
                        connectionsGameModel.resetNumMistakesRemaining()
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
