//
//  Extensions.swift
//  DefinitelyNotConnections
//
//  Created by Alex Jones on 12.01.26.
//

import Foundation

extension Array where Element: Any {
    mutating func replace(where condition: (Element) -> Bool, withResultOf generateNewElement: (Element) -> Element) {
        self = self.map({originalElement in
            condition(originalElement) ? generateNewElement(originalElement) : originalElement
        })
    }

    mutating func replace(where condition: (Element) -> Bool, with newElement: Element) {
        self = self.map({originalElement in
            condition(originalElement) ? newElement : originalElement
        })
    }

    func replaced(where condition: (Element) -> Bool, withResultOf generateNewElement: (Element) -> Element) -> [Element] {
        return self.map({originalElement in
            condition(originalElement) ? generateNewElement(originalElement) : originalElement
        })
    }
    
    func replaced(where condition: (Element) -> Bool, with newElement: Element) -> [Element] {
        return self.map({originalElement in
            condition(originalElement) ? newElement : originalElement} )
    }
}
