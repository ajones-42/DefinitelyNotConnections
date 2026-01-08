//
//  MistakesRemaining.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct MistakesRemainingView: View {
    var mistakes: Mistakes
    
    var body: some View {
        let shape = Circle().frame(width: 15).foregroundStyle(.foreground)
        HStack {
            Text("Mistakes remaining:")
                .fontWeight(.semibold)
            ForEach(0...3, id: \.self) {
                shape.opacity(mistakes.numMistakesRemaining > $0 ? 1 : 0)
            }
        }
    }
}

/*
#Preview {
    MistakesRemaining()
}
*/
