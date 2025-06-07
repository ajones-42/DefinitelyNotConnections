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
        HStack {
            Text("Mistakes remaining:")
                .fontWeight(.semibold)
            Circle()
                .foregroundStyle(connectionsGameViewModel.mistakesRemainingCircle1Colour)
                .frame(width: 15)
            Circle()
                .foregroundStyle(connectionsGameViewModel.mistakesRemainingCircle2Colour)
                .frame(width: 15)
            Circle()
                .foregroundStyle(connectionsGameViewModel.mistakesRemainingCircle3Colour)
                .frame(width: 15)
            Circle()
                .foregroundStyle(connectionsGameViewModel.mistakesRemainingCircle4Colour)
                .frame(width: 15)
        }
    }
}

/*
#Preview {
    MistakesRemaining()
}
*/
