//
//  CombineIteration.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 11/11/15.
//  Copyright © 2015 Cooper Knaak. All rights reserved.
//

import Foundation

public struct IterateWithGenerator<T: IteratorProtocol, U: IteratorProtocol>: IteratorProtocol, Sequence {
    
    public typealias Iterator = IterateWithGenerator
    public typealias Element   = (T.Element, U.Element)
    
    fileprivate var firstGenerator:T
    fileprivate var secondGenerator:U
    
    public init(first:T, second:U) {
        self.firstGenerator     = first
        self.secondGenerator    = second
    }
    
    public mutating func next() -> Element? {
        guard let first = self.firstGenerator.next(), let second = self.secondGenerator.next() else {
            return nil
        }
        return (first, second)
    }
    
    public func makeIterator() -> IterateWithGenerator {
        return self
    }
    
}

public struct EnumerateWithGenerator<T: IteratorProtocol, U: IteratorProtocol>: IteratorProtocol, Sequence {
    
    public typealias Iterator  = EnumerateWithGenerator
    public typealias Element    = (Int, T.Element, U.Element)
    
    fileprivate var firstGenerator:T
    fileprivate var secondGenerator:U
    fileprivate var index = 0
    
    public init(first:T, second:U) {
        self.firstGenerator     = first
        self.secondGenerator    = second
    }
    
    public mutating func next() -> Element? {
        guard let first = self.firstGenerator.next(), let second = self.secondGenerator.next() else {
            return nil
        }
        let currentIndex = self.index
        self.index += 1
        return (currentIndex, first, second)
    }
    
    public func makeIterator() -> Iterator {
        return self
    }
}

public struct EnumerateRangeWithGenerator<T: IteratorProtocol, U: IteratorProtocol>: IteratorProtocol, Sequence {
    
    public typealias Iterator  = EnumerateRangeWithGenerator
    public typealias Element    = (Int, T.Element, U.Element)
    
    fileprivate var firstGenerator:T
    fileprivate var secondGenerator:U
    fileprivate let range:CountableRange<Int>
    fileprivate var index = 0
    
    public init(first:T, second:U, range:CountableRange<Int>) {
        self.firstGenerator     = first
        self.secondGenerator    = second
        self.range              = range
    }
    
    public mutating func next() -> Element? {
        
        //Must generate until elements start at correct spot.
        while self.index < self.range.lowerBound {
            if self.firstGenerator.next() == nil || self.secondGenerator.next() == nil {
                return nil
            }
            self.index += 1
        }
        
        guard let first = self.firstGenerator.next(), let second = self.secondGenerator.next() , self.index < range.upperBound else {
            return nil
        }
        let currentIndex = self.index
        self.index += 1
        return (currentIndex, first, second)
    }
    
    public func makeIterator() -> Iterator {
        return self
    }
}

extension Sequence {
    
    public func iterateWith<T: Sequence>(_ otherSequence:T) -> IterateWithGenerator<Self.Iterator, T.Iterator> {
        return IterateWithGenerator(first: self.makeIterator(), second: otherSequence.makeIterator())
    }
    
    public func enumerateWith<T: Sequence>(_ otherSequence:T) -> EnumerateWithGenerator<Self.Iterator, T.Iterator> {
        return EnumerateWithGenerator(first: self.makeIterator(), second: otherSequence.makeIterator())
    }
    
    public func enumerateWith<T: Sequence>(_ otherSequence:T, range:CountableRange<Int>) -> EnumerateRangeWithGenerator<Self.Iterator, T.Iterator> {
        return EnumerateRangeWithGenerator(first: self.makeIterator(), second: otherSequence.makeIterator(), range: range)
    }
    
}
