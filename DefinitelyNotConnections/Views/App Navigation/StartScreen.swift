//
//  StartScreen.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 26.06.25.
//

import SwiftUI

struct StartScreen: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel

    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            VStack {
                Text("11th August, 2025")
                    .foregroundStyle(.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text("Group words that share a common thread.")
                    .foregroundStyle(.black)
                Button {
                    connectionsGameModel.startPlaying()
                } label: {
                    AppNavigationButton(text: "Play")
                }
                Text("No. 1")
                    .foregroundStyle(.black)
                Text("By Dr. Sir Master Lord Alexander Jones")
                    .foregroundStyle(.black)
                
            }
        }
    }
}

/*#Preview {
    StartScreen()
}
*/
