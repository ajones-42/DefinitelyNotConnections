//
//  CompletedCategoriesView.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 05.01.26.
//

import SwiftUI

struct CompletedCategoriesView: View {
    @Environment(MainGame.self) private var mainGame: MainGame

    var body: some View {
        ForEach(mainGame.getSortedCompletedCategories()) { category in
            CompletedCategoryView(category: category)
        }
    }
}

//#Preview {
    //CompletedCategoriesView()
//}
