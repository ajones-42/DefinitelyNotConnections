//
//  CompletedCategoriesView.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct CompletedCategoriesView: View {
    var categories: Categories

    var body: some View {
        ForEach(categories.sortedCompletedCategories) {category in
            CompletedCategoryView(category: category)
        }
    }
}

//#Preview {
    //CompletedCategoriesView()
//}
