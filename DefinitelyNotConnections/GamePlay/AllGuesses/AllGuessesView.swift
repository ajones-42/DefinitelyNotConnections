//
//  GuessesView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import SwiftUI

struct AllGuessesView: View {
    var allGuesses: AllGuesses
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
                ForEach(allGuesses.getGuesses()) {guess in
                        GuessView(guess: guess)
                }
            }
        }
        .padding()
    }
}

#Preview {
    struct Preview: View {
        let allGuesses: AllGuesses = AllGuessesBuilder().build()
        @State var isPresented: Bool = true
        var body: some View {
            AllGuessesView(allGuesses: allGuesses, guessesArePresented: $isPresented)
        }
    }
    return Preview()
}
