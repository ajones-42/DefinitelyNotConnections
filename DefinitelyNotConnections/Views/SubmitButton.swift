//
//  Submit.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct SubmitButton: View {
    @Binding var connectionsGameModel: ConnectionsGameModel
    @State private var clueBoxViewModel = ClueBoxViewModel(connectionsGameModel: connectionsGameModel)
    
    var body: some View {
        Button {
            connectionsGameModel.clickSubmit()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(connectionsGameModel.submitBoxColour)
                    .frame(width: 80, height: 40)
                Text("Submit")
                    .foregroundStyle(connectionsGameModel.submitTextColour)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
            }
        }
    }
}

@Observable
class ClueBoxViewModel {
    @Binding var connectionsGameModel: ConnectionsGameModel
    
    init(connectionsGameModel: ConnectionsGameModel) {
        self.connectionsGameModel = connectionsGameModel
    }
}

/*
#Preview {
    @State var model: ConnectionsGameModel = ConnectionsGameModel()
    SubmitButton(connectionsGameModel: $model)
}
*/
