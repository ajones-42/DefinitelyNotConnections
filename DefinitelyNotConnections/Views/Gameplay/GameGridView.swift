//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct GameGridView: View {
    @Environment(ConnectionsGameModel.self) private var connectionsGameModel: ConnectionsGameModel
    
    var body: some View {
        VStack {
            ForEach(connectionsGameModel.getCompletedCategories()) { category in
                CompletedCategoryView(category: category)
            }
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                ForEach(connectionsGameModel.getRemainingClueBoxes()) { clueBox in
                    ClueBoxView(clueBox: clueBox)
                        .onTapGesture {
                            connectionsGameModel.clickClueBox(clueBox: clueBox)
                        }
                }
            }
            MistakesRemainingView()
            HStack {
                ShuffleButtonView()
                DeselectAllButtonView()
                SubmitButtonView()
            }
        }
    }
}

/*
#Preview {
    ClueBoxGrid()
}
*/
