//
//  Extensions.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation

extension Array where Element: Any {
    mutating func replace(where condition: (Element) -> Bool, withResultOf generateNewElement: (Element) -> Element) {
        self = self.map( {condition($0) ? generateNewElement($0) : $0} )
    }

    mutating func replace(where condition: (Element) -> Bool, with newElement: Element) {
        self = self.map( {condition($0) ? newElement : $0} )
    }

    func replaced(where condition: (Element) -> Bool, withResultOf generateNewElement: (Element) -> Element) -> [Element] {
        return self.map( {condition($0) ? generateNewElement($0) : $0} )
    }
    
    func replaced(where condition: (Element) -> Bool, with newElement: Element) -> [Element] {
        return self.map( {condition($0) ? newElement : $0} )
    }
}
