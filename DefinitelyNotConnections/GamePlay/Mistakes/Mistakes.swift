//
//  Mistakes.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 08.01.26.
//

import Foundation


struct Mistakes {
    let numMistakesRemaining: Int
    var outOfMistakes: Bool {
        self.numMistakesRemaining == 0
    }
    
    func madeMistake() -> Mistakes {
        return Mistakes(numMistakesRemaining: self.numMistakesRemaining - 1)
    }
}
