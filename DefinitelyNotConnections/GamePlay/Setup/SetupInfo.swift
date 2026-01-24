//
//  SetupInfo.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 20.01.26.
//

import Foundation

struct SetupInfo {
    let categoryInfos: [CategoryInfo]
    let numCluesPerCategory: Int
    
    init(numCluesPerCategory: Int, categoryInfos: [CategoryInfo]) {
        self.categoryInfos = categoryInfos
        self.numCluesPerCategory = numCluesPerCategory
    }
    
    func getNumCategories() -> Int {
        return self.categoryInfos.count
    }
}
