//
//  CompletedCategory.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct CompletedCategory: View {
    var category: ConnectionsGameModel.Category

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 360, height: 80)
                .foregroundStyle(category.colour)
            VStack {
                Text(category.name)
                    .fontWeight(.semibold)
                Text(category.concatBoxTexts())
            }
        }
    }
}

/*
#Preview {
    CompletedCategory()
}
*/
