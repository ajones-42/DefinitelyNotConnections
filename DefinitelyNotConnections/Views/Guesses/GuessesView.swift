//
//  GuessesView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import SwiftUI

struct GuessesView: View {
    @Environment(MainGame.self) private var mainGame: MainGame
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
                ForEach(mainGame.getGuesses()) { guess in
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
