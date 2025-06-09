//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ClueBoxGrid: View {
    //@Environment(ConnectionsGameViewModel.self) private var connectionsGameViewModel: ConnectionsGameViewModel
    let connectionsGameViewModel: ConnectionsGameViewModel
    
    var body: some View {
        VStack {
            ForEach(connectionsGameViewModel.categories) { category in
                if category.isCompleted {
                    CompletedCategory(category: category)
                }
            }
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                ForEach(connectionsGameViewModel.clueBoxes) { clueBox in
                    ClueBoxStyle(clueBox: clueBox)
                        .onTapGesture {
                            connectionsGameViewModel.clickClueBox(clueBox: clueBox)
                        }
                }
            }
        }
    }
}

/*
#Preview {
    ClueBoxGrid()
}
*/
