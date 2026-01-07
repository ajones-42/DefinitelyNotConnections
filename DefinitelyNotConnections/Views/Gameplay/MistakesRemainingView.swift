//
//  MistakesRemaining.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct MistakesRemainingView: View {
    @Environment(MainGame.self) private var mainGame: MainGame
    
    var body: some View {
        let shape = Circle().frame(width: 15).foregroundStyle(.foreground)
        HStack {
            Text("Mistakes remaining:")
                .fontWeight(.semibold)
            ForEach(0...3, id: \.self) {
                shape.opacity(mainGame.getNumMistakesRemaining() > $0 ? 1 : 0)
            }
        }
    }
}

/*
#Preview {
    MistakesRemaining()
}
*/
