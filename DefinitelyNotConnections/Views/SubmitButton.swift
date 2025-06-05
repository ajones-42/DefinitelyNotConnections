//
//  Submit.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct SubmitButton: View {
    @Binding var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        Button {
            connectionsGameModel.clickSubmit()
        } label: {
            NormalButton(text: "Submit", boxColour: connectionsGameModel.submitBoxColour, textColour: connectionsGameModel.submitTextColour)
        }
    }
}

/*
#Preview {
    @State var model: ConnectionsGameModel = ConnectionsGameModel()
    SubmitButton(connectionsGameModel: $model)
}
*/
