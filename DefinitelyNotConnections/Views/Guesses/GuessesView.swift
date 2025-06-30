//
//  GuessesView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import SwiftUI

struct GuessesView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    @Binding var guessesArePresented: Bool

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    guessesArePresented.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.foreground)
                }
            }
            .padding()
            List {
                ForEach(connectionsGameModel.guesses) { guess in
                        GuessView(guess: guess)
                }
            }
        }
        .padding()
    }
}

/*#Preview {
    GuessesView()
}*/
