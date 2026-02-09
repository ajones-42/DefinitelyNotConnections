//
//  CompletedConnectionsCategoriesView.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct CompletedConnectionsCategoriesView: View {
    var connectionsCategories: ConnectionsCategories

    var body: some View {
        ForEach(connectionsCategories.sortedCompletedConnectionsCategories) {connectionsCategory in
            CompletedConnectionsCategoryView(connectionsCategory: connectionsCategory)
        }
    }
}

#Preview {
    let gameProperties: GameProperties = GamePropertiesBuilder().build()
    let connectionsCategories: ConnectionsCategories = try! ConnectionsCategoriesBuilder().withCompleteAllConnectionsCategories().build()
    return CompletedConnectionsCategoriesView(connectionsCategories: connectionsCategories)
}
