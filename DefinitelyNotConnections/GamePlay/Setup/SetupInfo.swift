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
}
