//
//  CompletedCategoriesView.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct CompletedCategoriesView: View {
    var categories: GameGrid

    var body: some View {
        ForEach(categories.sortedCompletedCategories) {category in
            CompletedCategoryView(category: category)
        }
    }
}

#Preview {
    let categories: GameGrid = GameGridBuilder().completeAllCategories().build()
    CompletedCategoriesView(categories: categories)
}
