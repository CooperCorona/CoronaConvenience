//
//  Array+Convenience.swift
//  InverseKinematicsTest
//
//  Created by Cooper Knaak on 10/13/14.
//  Copyright (c) 2014 Cooper Knaak. All rights reserved.
//

import Foundation

extension Array {
    
    public var range:CountableRange<Int> { return 0..<self.count }
    
    public func size() -> Int {
        
            if (self.count == 0) {
                    return 0
            }//no elements
        
        return MemoryLayout.size(ofValue: self[0]) * self.count
    }//get size
    
    /*
     *  For some reason, casting arc4random() to Int
     *  crashes on iPad 2 device. Casting the result
     *  of arc4random() % self.count (where self.count
     *  is itself cast to UInt32) to Int succeeds
     */
    public func randomObject() -> Element? {
        
        if (self.count <= 0) {
            return nil
        }
        
        let index = Int(arc4random() % UInt32(self.count))
        return self[index]
    }//get a random object
    
    /**
    Removes a random object from the array.
    
    - returns: The element removed, or nil if the array was empty.
    */
    public mutating func removeRandomObject() -> Element? {
        if self.count <= 0 {
            return nil
        }
        
        let index = Int(arc4random() % UInt32(self.count))
        return self.remove(at: index)
    }
    
    /**
    Safely gets the object at the index from the array.
    
    - parameter index: The index of the object to get.
    - returns: The object at *index*, or nil if no object exists.
    */
    public func objectAtIndex(_ index:Int) -> Element? {
        if index < 0 || index >= self.count {
            return nil
        }

        return self[index]
    }
    
    /**
    Adds enough values to the end the array so that it has a specified length.
    
    - parameter value: The value to be repeated.
    - parameter length: The final length of the array.
    */
    public mutating func pad(_ value:Element, toLength length:Int) {
        
        while self.count < length {
            self.append(value)
        }
    }
    
    public func find(_ predicate:(Element) throws -> Bool) -> Element? {
        do {
            if let index = try self.index(where: predicate) {
                return self[index]
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    /**
    Iterates through the array, comparing elements to find which is the desired one.
    
    - parameter isBetter: A closure that takes two elements and returns which one is considered better.
    - returns: The element that was determined to be the best, according to *isBetter* or nil if the array is empty.
    */
    public func findBest(_ isBetter:(Element, Element) -> Element) -> Element? {
        guard var bestElement = self.first else {
            return nil
        }
        for (_, element) in self.enumerateSkipFirst() {
            bestElement = isBetter(bestElement, element)
        }
        
        return bestElement
    }
    
    /**
    Iterates through the array, comparing elements to find which is the desired one.
    
    - parameter isBetter: A closure that takes two elements and returns true if the first is considered better.
    - returns: The element that was determined to be the best, according to *isBetter* or nil if the array is empty.
    */
    public func findBest(_ isBetter:(Element, Element) -> Bool) -> Element? {
        guard var bestElement = self.first else {
            return nil
        }
        for (_, element) in self.enumerateSkipFirst() {
            bestElement = isBetter(bestElement, element) ? bestElement : element
        }
        return bestElement
    }
    
    /**
    Iterates through the array until it finds an element that
    satisfies *predicate*.
    - parameter predicate: A closure that accepts and Element and returns *true* iff that is the desired element.
    - returns: The first element found that satisfies *predicate*, or *nil* if no such element exists.
    */
    public func findObject(_ predicate:(Element) -> Bool) -> Element? {
        for object in self {
            if predicate(object) {
                return object
            }
        }
        return nil
    }
    
    /**
    Copies this array and adds enough values to the end so that it has a specified length.
    
    - parameter value: The value to be repeated.
    - parameter length: The final length of the array.
    - returns: An array with length *length*.
    */
    public func arrayByPadding(_ value:Element, toLength length:Int) -> [Element] {
        
        var newArray = self
        newArray.pad(value, toLength: length)
        return newArray
    }
    
    
    public func recursiveReduce(_ firstValue:Element, handler:(Element) -> [Element]) -> [Element] {
        return [firstValue] + handler(firstValue).recursiveReduce(handler)
    }
    
    public func recursiveReduce(_ handler:(Element) -> [Element]) -> [Element] {
        var array:[Element] = []
        for value in self {
            array.append(value)
            array += handler(value).recursiveReduce(handler)
        }
        return array
    }
    
    
    /**
    Uses the insertion sort algorithm to sort this array. Stable.
    
    - parameter isOrderedBefore: A closure taking two elements and returning whether the 1st should be placed before the 2nd.
    */
    public mutating func insertionSortInPlace(_ isOrderedBefore: (Element, Element) -> Bool) {
        
        if self.count <= 1 {
            return
        }
        
        for iii in 1..<self.count {
            var jjj = iii
            while jjj > 0 && isOrderedBefore(self[jjj], self[jjj - 1]) {
                swap(&self[jjj - 1], &self[jjj])
                jjj -= 1
            }
        }
        
    }
    
    /**
    Uses the insertion sort algorithm to sort a copy of this array. Stable.
    
    - parameter isOrderedBefore: A closure taking two elements and returning whether the 1st should be placed before the 2nd.
    - returns: A copy of this array, sorted according to isOrderedBefore.
    */
    public func insertionSort(_ isOrderedBefore: (Element, Element) -> Bool) -> [Element] {
        var sortedArray = self
        sortedArray.insertionSortInPlace(isOrderedBefore)
        return sortedArray
    }
    
    
    
    public func enumerateSkipFirst() -> SliceEnumerateSequence<Array> {
        if self.count == 0 {
            return SliceEnumerateSequence(base: self, range: 0..<0)
        } else {
            return self.enumerateRange(1..<self.count)
        }
    }
    
    public func enumerateSkipLast() -> SliceEnumerateSequence<Array> {
        if self.count == 0 {
            return SliceEnumerateSequence(base: self, range: 0..<0)
        } else {
            return self.enumerateRange(0..<self.count - 1)
        }
    }
    
    public func enumerateRepeatFirst() -> RepeatEnumerateSequence<Array> {
        return RepeatEnumerateSequence(base: self)
    }
    
    /**
     Removes the elements at the given indices, making sure to remove them in the correct order so the right indices are removed.
     
     - parameter indices: The indices to remove. It is a set because trying to remove the same index twice would screw up.
     - returns: The elements at the removed indices.
    */
    public mutating func removeAtIndices(_ indices:Set<Int>) -> [Element] {
        var removedElements:[Element] = []
        for index in indices.sorted(by: { $0 > $1 }) {
            removedElements.append(self.remove(at: index))
        }

        return removedElements
    }
    
}//extend Array

public func removeObject<T: AnyObject>(_ object:T, fromArray:inout Array<T>) -> T? {
    
    for iii in 0..<fromArray.count {
        
        if (object === fromArray[iii])
        {//found object
            fromArray.remove(at: iii)
            return object
        }//found object
        
    }//loop through array
    
    return nil
}//remove object

public func removeObjects<T: AnyObject>(_ objects:[T], fromArray:inout [T]) {
    
    for curObject in objects {
        
        /*for iii in 0..<fromArray.count {
            if (curObject === fromArray[iii]) {
                fromArray.removeAtIndex(iii)
                break
            }
        }*/
        let _ = removeObject(curObject, fromArray: &fromArray)
        
    }
    
}//remove objects

public func object<T>(_ array:[T], atIndex index:Int) -> T? {
    
    if index < 0 || index >= array.count {
        return nil
    }
    
    return array[index]
}

public func pad<T>(_ value:T, array:inout [T], toLength length:Int) {
    while array.count < length {
        array.append(value)
    }
}

public func array<T>(_ array:[T], byPadding value:T, toLength length:Int) -> [T] {
    var paddedArray = array
    pad(value, array: &paddedArray, toLength: length)
    return paddedArray
}

// MARK: - Sliced Enumeration
public struct SliceEnumerateGenerator<Base: IteratorProtocol>: IteratorProtocol, Sequence {
    
    public typealias Element = (index: Int, element: Base.Element)
    public typealias Iterator = SliceEnumerateGenerator
    
    fileprivate var base:Base
    fileprivate let range:CountableRange<Int>
    fileprivate var index:IndexingIterator<CountableRange<Int>>
    fileprivate var firstTime = true
    
    init(base: Base, range:CountableRange<Int>) {
        self.base   = base
        self.range  = range
        self.index  = range.makeIterator()
    }
    
    mutating public func next() -> Element? {
        
        //Makes sure you start at right index,
        //otherwise you start generating at the
        //first index, which is not what I want.
        if self.firstTime {
            
            for _ in 0..<self.range.lowerBound {
                if self.base.next() == nil {
                    return nil
                }
            }
            
            self.firstTime = false
        }
        
        if let nextBase = base.next(), let currentIndex = self.index.next() {
            return (index: currentIndex, element: nextBase)
        } else {
            return nil
        }
    }
    
    public func makeIterator() -> Iterator {
        return self
    }
    
    public func allElements(_ predicate:(Element) -> Bool) -> Bool {
        return self.reduce(true) { $0 && predicate($1) }
    }
    
    public func noElements(_ predicate:(Element) -> Bool) -> Bool {
        return !self.reduce(false) { !$0 && predicate($1) }
    }
    
}

public struct SliceEnumerateSequence<Base: Sequence>: Sequence {
    
    public typealias Iterator = SliceEnumerateGenerator<Base.Iterator>
    
    fileprivate var base:Base
    fileprivate let range:CountableRange<Int>
    
    init(base:Base, range:CountableRange<Int>) {
        self.base   = base
        self.range  = range
    }

    public func makeIterator() -> Iterator {
        return SliceEnumerateGenerator(base: base.makeIterator(), range: range)
    }
    
}

public struct RepeatEnumerateGenerator<Base: IteratorProtocol>: IteratorProtocol, Sequence {
    
    fileprivate var base:Base?
    fileprivate var first:Base.Element? = nil
    fileprivate var index = 0
    
    public init(base:Base) {
        self.base = base
    }
    
    public mutating func next() -> (Int, Base.Element)? {
        if let value = self.base?.next() {
            if self.first == nil {
                self.first = value
            }
            let index = self.index
            self.index += 1
            return (index, value)
        } else {
            if let value  = self.first {
                self.base  = nil
                self.first = nil
                return (0, value)
            } else {
                return nil
            }
        }
    }
    
    public func makeIterator() -> RepeatEnumerateGenerator {
        return self
    }
    
}

public struct RepeatEnumerateSequence<Base: Sequence>: Sequence {
    
    fileprivate let base:Base
    
    init(base:Base) {
        self.base = base
    }
    
    public func makeIterator() -> RepeatEnumerateGenerator<Base.Iterator> {
        return RepeatEnumerateGenerator(base: base.makeIterator())
    }
    
}

extension Sequence {
    
    ///Enumerates the array, returning (index, element) pairs, but only for a given range.
    public func enumerateRange(_ range:Range<Int>) -> SliceEnumerateSequence<Self> {
        return SliceEnumerateSequence(base: self, range: CountableRange(range))
    }
    
    ///Enumerates the array, returning (index, element) pairs, but only for a given range.
    public func enumerateRange(_ range:CountableRange<Int>) -> SliceEnumerateSequence<Self> {
        return SliceEnumerateSequence(base: self, range: range)
    }
    
    ///Enumerates the array, returning (index, element) pairs, but only for a given range.
    public func enumerateRange(_ range:CountableClosedRange<Int>) -> SliceEnumerateSequence<Self> {
        return SliceEnumerateSequence(base: self, range: CountableRange(range))
    }
    
}

extension Collection {
    
    public func randomElement() -> Self.Iterator.Element? {
        
        guard self.count > 0 else {
            return nil
        }
        
        let index = Int(arc4random() % UInt32(self.count.toIntMax()))
        for (i, element) in self.enumerated() where i == index {
            return element
        }
        return nil
    }
    
}
