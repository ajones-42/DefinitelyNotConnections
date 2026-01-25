//
//  SetupInfo.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 20.01.26.
//

import Foundation

struct SetupInfo {
    let categoryInfos: [CategoryInfo]
    let numMistakes: Int
    
    init(categoryInfos: [CategoryInfo], numMistakes: Int) {
        self.categoryInfos = categoryInfos
        self.numMistakes = numMistakes
    }
}
