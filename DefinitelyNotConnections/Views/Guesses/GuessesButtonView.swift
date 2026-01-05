//
//  GuessesButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 01.07.25.
//

import SwiftUI

struct GuessesButtonView: View {
    @Environment(MainGame.self) private var mainGame: MainGame
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
                .environment(mainGame)
        }
    }
}

/*#Preview {
    GuessesButtonView()
}*/
