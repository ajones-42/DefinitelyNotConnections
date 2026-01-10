//
//  ClueBoxGrid.swift
//  DefinitelyNotConnections
//
//  Created by Alexander Jones on 02.06.25.
//

import SwiftUI

struct GameGridView: View {
    
    var body: some View {
        VStack {
            CompletedCategoriesView()
            RemainingClueBoxesView()
        }
    }
}

/*
#Preview {
    ClueBoxGrid()
}
*/
