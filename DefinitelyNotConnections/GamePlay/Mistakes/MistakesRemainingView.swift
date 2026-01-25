//
//  MistakesRemaining.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct MistakesRemainingView: View {
    let mistakes: Mistakes
    
    var body: some View {
        let mistakeIndicator = Circle().frame(width: 15).foregroundStyle(.foreground)
        HStack {
            Text("Mistakes remaining:")
                .fontWeight(.semibold)
            ForEach(0...mistakes.getOriginalNumMistakes() - 1, id: \.self) {mistakeNumber in
                mistakeIndicator.opacity(mistakes.numMistakesRemaining > mistakeNumber ? 1 : 0)
            }
        }
    }
}

/*
#Preview {
    MistakesRemaining()
}
*/
