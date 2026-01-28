//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct CategoriesView: View {
    let categories: Categories
    
    var body: some View {
        VStack {
            CompletedCategoriesView(categories: categories)
            RemainingClueBoxesView(allClueBoxes: categories.allClueBoxes)
        }
    }
}

#Preview {
    let categories: Categories = CategoriesBuilder().build()
    CategoriesView(categories: categories)
}
