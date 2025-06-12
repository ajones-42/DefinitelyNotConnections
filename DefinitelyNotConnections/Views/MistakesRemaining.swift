//
//  MistakesRemaining.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct MistakesRemaining: View {
    //@Environment(ConnectionsGameViewModel.self) private var connectionsGameViewModel: ConnectionsGameViewModel
    let connectionsGameViewModel: ConnectionsGameViewModel
    
    var body: some View {
        let shape = Circle().frame(width: 15)
        HStack {
            Text("Mistakes remaining:")
                .fontWeight(.semibold)
            if connectionsGameViewModel.mistakesRemainingCircle1Shown {
                shape.foregroundStyle(.foreground)
            } else {
                shape.foregroundStyle(.background)
            }
            if connectionsGameViewModel.mistakesRemainingCircle2Shown {
                shape.foregroundStyle(.foreground)
            } else {
                shape.foregroundStyle(.background)
            }
            if connectionsGameViewModel.mistakesRemainingCircle3Shown {
                shape.foregroundStyle(.foreground)
            } else {
                shape.foregroundStyle(.background)
            }
            if connectionsGameViewModel.mistakesRemainingCircle4Shown {
                shape.foregroundStyle(.foreground)
            } else {
                shape.foregroundStyle(.background)
            }
        }
    }
}

/*
#Preview {
    MistakesRemaining()
}
*/
