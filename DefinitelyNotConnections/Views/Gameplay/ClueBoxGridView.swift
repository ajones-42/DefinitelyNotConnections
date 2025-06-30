//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct ClueBoxGridView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        VStack {
            ForEach(connectionsGameModel.completedCategories) { category in
                CompletedCategoryView(category: category)
            }
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                ForEach(connectionsGameModel.clueBoxes) { clueBox in
                    ClueBoxView(clueBox: clueBox)
                        .onTapGesture {
                            connectionsGameModel.clickClueBox(clueBox: clueBox)
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
