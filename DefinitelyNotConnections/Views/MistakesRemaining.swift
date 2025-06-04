//
//  MistakesRemaining.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct MistakesRemaining: View {
    @Binding var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        HStack {
            Text("Mistakes remaining:")
                .fontWeight(.semibold)
            Circle()
                .foregroundStyle(connectionsGameModel.mistakesRemainingCircle1Colour)
                .frame(width: 15)
            Circle()
                .foregroundStyle(connectionsGameModel.mistakesRemainingCircle2Colour)
                .frame(width: 15)
            Circle()
                .foregroundStyle(connectionsGameModel.mistakesRemainingCircle3Colour)
                .frame(width: 15)
            Circle()
                .foregroundStyle(connectionsGameModel.mistakesRemainingCircle4Colour)
                .frame(width: 15)
        }
    }
}

/*
#Preview {
    MistakesRemaining()
}
*/
