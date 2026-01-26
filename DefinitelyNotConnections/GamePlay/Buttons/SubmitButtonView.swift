//
//  Submit.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct SubmitButtonView: View {
    @Environment(MainGame.self) private var mainGame: MainGame
    
    var body: some View {
        Button {
            mainGame.submitSelection()
        } label: {
            GameplayButtonView(text: "Submit", isClickable: mainGame.getSubmitIsClickable())
        }
    }
}


#Preview {
    let setupInfo: SetupInfo = createDefaultTestSetupInfo()
    let mainGame: MainGame = MainGameBuilder(setupInfo: setupInfo).build()
    SubmitButtonView()
        .environment(mainGame)
}
