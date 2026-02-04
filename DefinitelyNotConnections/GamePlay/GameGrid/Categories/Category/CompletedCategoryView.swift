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
                Text(concatClues(clues: category.getClues()))
                    .foregroundStyle(.black)
                    .frame(maxWidth: rectangleWidth - 10)
            }
        }
    }
}


#Preview {
    let categoryInfo: CategoryInfo = try! createTestCategoryInfos(numCategories: 1, colours: [.green], numCluesPerCategory: 4).first!
    let category: Category = CategoryBuilder(categoryInfo: categoryInfo).build()
    CompletedCategoryView(category: category)
}

