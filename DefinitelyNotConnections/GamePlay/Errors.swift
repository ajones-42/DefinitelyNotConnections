//
//  Errors.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 27.12.25.
//

import Foundation

enum ValidationError: Error {
    case invalidInput
    case unknownConnectionsCategoryID
    case alreadyCompletedConnectionsCategory
    case invalidNumMistakesRemaining
    case submissionError
}
