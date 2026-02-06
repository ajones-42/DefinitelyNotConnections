//
//  SetupInfo.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 20.01.26.
//

import Foundation

struct SetupInfo {
    let connectionsCategoryInfos: [ConnectionsCategoryInfo]
    let numMistakes: Int
    
    init(connectionsCategoryInfos: [ConnectionsCategoryInfo], numMistakes: Int) {
        self.connectionsCategoryInfos = connectionsCategoryInfos
        self.numMistakes = numMistakes
    }
}
