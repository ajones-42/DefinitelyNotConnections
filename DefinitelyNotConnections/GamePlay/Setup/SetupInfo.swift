//
//  SetupInfo.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 20.01.26.
//

import Foundation

struct SetupInfo {
    let categoryInfos: [CategoryInfo]
    
    init(categoryInfos: [CategoryInfo]) {
        self.categoryInfos = categoryInfos
    }
    
    func getNumCategories() -> Int {
        return self.categoryInfos.count
    }
    
    func getNumCluesPerCategory() -> Int? {
        let uniqueNumClues: Set<Int> = Set(self.categoryInfos.map({categoryInfo in
            categoryInfo.clueInfos.count
        }))
        return uniqueNumClues.first
    }
}
