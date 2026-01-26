//
//  GamePropertiesBuilder.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 26.01.26.
//

import Foundation

class GamePropertiesBuilder {
    var numMistakes: Int = 4
    var numCategories: Int = 4
    var numCluesPerCategory: Int = 4
    
    func withNumMistakes(numMistakes: Int) -> GamePropertiesBuilder {
        self.numMistakes = numMistakes
        return self
    }
    
    func withNumCategories(numCategories: Int) -> GamePropertiesBuilder {
        self.numCategories = numCategories
        return self
    }
    
    func withNumCluesPerCategory(numCluesPerCategory: Int) -> GamePropertiesBuilder {
        self.numCluesPerCategory = numCluesPerCategory
        return self
    }
    
    func build() -> GameProperties {
        return GameProperties(numMistakes: self.numMistakes, numCategories: self.numCategories, numCluesPerCategory: self.numCluesPerCategory)
    }
}
