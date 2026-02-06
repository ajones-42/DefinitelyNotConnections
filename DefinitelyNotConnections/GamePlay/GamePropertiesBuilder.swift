//
//  GamePropertiesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class GamePropertiesBuilder {
    var numMistakes: Int = 4
    var numConnectionsCategories: Int = 4
    var numCluesPerConnectionsCategory: Int = 4
    
    func withNumMistakes(numMistakes: Int) -> GamePropertiesBuilder {
        self.numMistakes = numMistakes
        return self
    }
    
    func withNumConnectionsCategories(numConnectionsCategories: Int) -> GamePropertiesBuilder {
        self.numConnectionsCategories = numConnectionsCategories
        return self
    }
    
    func withNumCluesPerConnectionsCategory(numCluesPerConnectionsCategory: Int) -> GamePropertiesBuilder {
        self.numCluesPerConnectionsCategory = numCluesPerConnectionsCategory
        return self
    }
    
    func build() -> GameProperties {
        return GameProperties(numMistakes: self.numMistakes, numConnectionsCategories: self.numConnectionsCategories, numCluesPerConnectionsCategory: self.numCluesPerConnectionsCategory)
    }
}
