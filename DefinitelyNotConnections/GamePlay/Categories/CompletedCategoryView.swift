//
//  CompletedCategory.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 09.06.25.
//

import SwiftUI

struct CompletedCategoryView: View {
    let category: Category
    let rectangleWidth: CGFloat = 360

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: rectangleWidth, height: 80)
                .foregroundStyle(category.colour)
            VStack {
                Text(category.name)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .frame(maxWidth: rectangleWidth - 10)
                Text(concatBoxTexts(clueBoxes: category.clueBoxes))
                    .foregroundStyle(.black)
                    .frame(maxWidth: rectangleWidth - 10)
            }
        }
    }
}

/*
#Preview {
    CompletedCategory()
}
*/
