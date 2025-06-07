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
    
    var body: some View {
        Button {
            connectionsGameViewModel.clickSubmit()
        } label: {
            NormalButton(text: "Submit", boxColour: connectionsGameViewModel.submitBoxColour, textColour: connectionsGameViewModel.submitTextColour)
        }
    }
}

/*
#Preview {
    @State var model: ConnectionsGameModel = ConnectionsGameModel()
    SubmitButton(connectionsGameModel: $model)
}
*/
