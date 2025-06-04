//
//  DeselectAllButton.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 03.06.25.
//

import SwiftUI

struct DeselectAllButton: View {
    @Binding var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        Button {
            connectionsGameModel.deselectAll()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(connectionsGameModel.deselectAllBoxColour)
                    .frame(width: 80, height: 40)
                Text("Deselect All")
                    .foregroundStyle(connectionsGameModel.deselectAllTextColour)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
            }
        }
    }
}

/*
#Preview {
    DeselectAllButton()
}
*/
