//
//  CompletedConnectionsCategory.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct CompletedConnectionsCategoryView: View {
    let connectionsCategory: ConnectionsCategory
    let rectangleWidth: CGFloat = 360

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: rectangleWidth, height: 80)
                .foregroundStyle(connectionsCategory.colour)
            VStack {
                Text(connectionsCategory.name)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(maxWidth: rectangleWidth - 10)
                Text(concatClues(clues: connectionsCategory.getClues()))
                    .foregroundStyle(.black)
                    .frame(maxWidth: rectangleWidth - 10)
            }
        }
    }
}


#Preview {
    let connectionsCategoryInfo: ConnectionsCategoryInfo = try! createTestConnectionsCategoryInfos(numConnectionsCategories: 1, colours: [.green], numCluesPerConnectionsCategory: 4).first!
    let connectionsCategory: ConnectionsCategory = ConnectionsCategoryBuilder(connectionsCategoryInfo: connectionsCategoryInfo).build()
    CompletedConnectionsCategoryView(connectionsCategory: connectionsCategory)
}

