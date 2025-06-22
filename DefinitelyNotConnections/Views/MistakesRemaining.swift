//
//  MistakesRemaining.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct MistakesRemaining: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        let shape = Circle().frame(width: 15)
        HStack {
            Text("Mistakes remaining:")
                .fontWeight(.semibold)
            ForEach(0...3, id: \.self) {
                if connectionsGameModel.numMistakesRemaining > $0 {
                    shape.foregroundStyle(.foreground)
                } else {
                    shape.foregroundStyle(.background)
                }
            }
        }
    }
}

/*
#Preview {
    MistakesRemaining()
}
*/
