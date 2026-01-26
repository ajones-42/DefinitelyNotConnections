//
//  GuessesButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 01.07.25.
//

import SwiftUI

struct GuessesButtonView: View {
    var allGuesses: AllGuesses
    @State var guessesArePresented: Bool = false

    var body: some View {
        Button {
            guessesArePresented.toggle()
        } label: {
            Image(systemName: "eye.fill")
                .foregroundStyle(.foreground)
                .frame(width: 60)
                .padding()
        }
        .sheet(isPresented: $guessesArePresented, onDismiss: {}) {
            AllGuessesView(allGuesses: allGuesses, guessesArePresented: $guessesArePresented)
                .presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    struct Preview: View {
        let allGuesses: AllGuesses = AllGuessesBuilder().build()
        @State var isPresented: Bool = true
        var body: some View {
            GuessesButtonView(allGuesses: allGuesses, guessesArePresented: isPresented)
        }
    }
    return Preview()
}
