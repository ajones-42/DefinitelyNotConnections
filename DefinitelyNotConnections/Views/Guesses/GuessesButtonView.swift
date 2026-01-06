//
//  GuessesButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 01.07.25.
//

import SwiftUI

struct GuessesButtonView: View {
    // GuessesView can get allGuesses from the environment without this, but this is clearer.
    @Environment(AllGuesses.self) private var allGuesses: AllGuesses
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
            GuessesView(guessesArePresented: $guessesArePresented)
                .presentationDetents([.fraction(0.4)])
                .environment(allGuesses)
        }
    }
}

/*#Preview {
    GuessesButtonView()
}*/
