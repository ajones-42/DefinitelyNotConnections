//
//  GuessView.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 30.06.25.
//

import SwiftUI

struct GuessView: View {
    var guess: Guess
    
    var body: some View {
        Text(guess.getGuessText())
    }
}

/* #Preview {
    GuessView()
}*/
