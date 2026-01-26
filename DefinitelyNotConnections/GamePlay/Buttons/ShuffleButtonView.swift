//
//  ShuffleButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct ShuffleButtonView: View {
    @Environment(MainGame.self) private var mainGame: MainGame
    
    var body: some View {
        Button {
            mainGame.shuffleClueBoxes()
        } label: {
            GameplayButtonView(text: "Shuffle", isClickable: true)
        }
    }
}


#Preview {
    let setupInfo: SetupInfo = createDefaultTestSetupInfo()
    let mainGame: MainGame = MainGameBuilder(setupInfo: setupInfo).build()
    ShuffleButtonView()
        .environment(mainGame)
}
