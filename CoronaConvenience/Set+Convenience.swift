//
//  Set+Convenience.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 11/29/15.
//  Copyright © 2015 Cooper Knaak. All rights reserved.
//

import Foundation

// MARK: - Convenience Methods
extension Set {
    
    public init(array:[Element]) {
        self.init(minimumCapacity: array.count)
        for value in array {
            self.insert(value)
        }
    }
    
    public mutating func insert(_ array:[Element]) {
        for element in array {
            self.insert(element)
        }
    }
    
    public func toArray() -> [Element] {
        var array:[Element] = []
        for value in self {
            array.append(value)
        }
        return array
    }
    
    public mutating func removeRandomObject() -> Element? {
        guard let element = self.randomElement() else {
            return nil
        }
        self.remove(element)
        return element
    }
    
    public func powerSet() -> Set<Set<Element>> {
        let list = self.map() { $0 }
        var sets = Set<Set<Element>>()
        for j in 0..<(1 << self.count) {
            var currentSet = Set<Element>()
            for i in 0..<self.count {
                if (j & (1 << i)) != 0 {
                    currentSet.insert(list[i])
                }
            }
            sets.insert(currentSet)
        }
        return sets
    }
    
}
