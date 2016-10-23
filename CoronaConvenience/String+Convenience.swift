//
//  String+Convenience.swift
//  Gravity
//
//  Created by Cooper Knaak on 4/20/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif

extension String {
    
    // MARK: - Typecasting
    
    public func getIntegerValue() -> Int       { return (self as NSString).integerValue }
    
    public func getCGFloatValue() -> CGFloat   { return CGFloat((self as NSString).floatValue) }
    
    public func getBoolValue() -> Bool          { return (self as NSString).boolValue }
    
    // MARK: - Characters
    
    public var characterCount:Int {
        return self.characters.distance(from: self.startIndex, to: self.endIndex)
    }
    
    public subscript(index:Int) -> Character? {
        
        if index < 0 || index >= self.characterCount {
            return nil
        }
        
        let stringIndex = self.characters.index(self.startIndex, offsetBy: index)
        return self[stringIndex]
    }
    
    ///Returns the substring at a given range.
    public subscript(range:Range<Int>) -> String {
        let startIndex  = self.characters.index(self.startIndex, offsetBy: range.lowerBound)
        let endIndex    = self.characters.index(self.startIndex, offsetBy: range.upperBound)
        return self.substring(with: startIndex..<endIndex)
    }
    
    ///Returns the substring at a given range.
    subscript(index:CountableRange<Int>) -> String {
        let lowerBound = self.index(self.startIndex, offsetBy: index.lowerBound)
        let upperBound = self.index(self.startIndex, offsetBy: index.upperBound)
        return self[lowerBound..<upperBound]
    }
    
    ///Returns the substring at a given range.
    subscript(index:CountableClosedRange<Int>) -> String {
        let lowerBound = self.index(self.startIndex, offsetBy: index.lowerBound)
        let upperBound = self.index(self.startIndex, offsetBy: index.upperBound)
        return self[lowerBound...upperBound]
    }
    
    ///Returns the substring at a given range.
    subscript(index:ClosedRange<Int>) -> String {
        let lowerBound = self.index(self.startIndex, offsetBy: index.lowerBound)
        let upperBound = self.index(self.startIndex, offsetBy: index.upperBound)
        return self[lowerBound...upperBound]
    }
    
    public var firstCharacter:Character? {
        
        if self == "" {
            return nil
        }
        
        return self[self.startIndex]
    }
    
    public var lastCharacter:Character? {
        
        if self == "" {
            return nil
        }
        
        return self[self.characters.index(self.endIndex, offsetBy: -1)]
    }
    
    public mutating func removeCharacterAtIndex(_ index:Int) -> Character? {
        
        if index < 0 || index >= self.characterCount {
            return nil
        }
        
        let stringIndex = self.characters.index(self.startIndex, offsetBy: index)
        return self.remove(at: stringIndex)
    }
    
    public mutating func setCharacter(_ char:Character, atIndex index:Int) {
        
        if index >= 0 && index < self.characterCount {
            let stringIndex = self.characters.index(self.startIndex, offsetBy: index)
            self.replaceSubrange(stringIndex...stringIndex, with: "\(char)")
        }
        
        
    }
    
    public mutating func removeFirst() -> Character? {
        if self == "" {
            return nil
        }
        
        return self.remove(at: self.startIndex)
    }
    
    public mutating func removeLast() -> Character? {
        
        if self == "" {
            return nil
        }
        
        let index = self.characters.index(self.startIndex, offsetBy: self.characters.distance(from: self.startIndex, to: self.endIndex) - 1)
        return self.remove(at: index)
    }
    
    public func convertCamelCaseToSpaces() -> String {
        let uppercaseSet = CharacterSet.uppercaseLetters
        var str = self[0...0]
        for (iii, character) in self.utf16.enumerateRange(1..<self.characterCount) {
            if uppercaseSet.contains(UnicodeScalar(character)!) {
                str += " "
            }
            if let curChar = self[iii] {
                str.append(curChar)
            }
        }
        return str
    }
    
    public func removeAllWhiteSpace() -> String {
        return self.components(separatedBy: CharacterSet.whitespaces).filter() { $0 != "" } .reduce("") { $0 + $1 }
    }
}



public struct StringCharacterGenerator: IteratorProtocol, Sequence {
    
    public typealias Element   = Character
    public typealias Iterator = StringCharacterGenerator
    
    fileprivate let base:String
    fileprivate var index = 0
    
    public init(base:String) {
        self.base = base
    }
    
    public mutating func next() -> Element? {
        self.index += 1
        return self.base[self.index]
    }
    
    public func makeIterator() -> Iterator {
        return self
    }
    
}

extension String: Sequence {
    
    public typealias Iterator = StringCharacterGenerator
    
    public func makeIterator() -> Iterator {
        return StringCharacterGenerator(base: self)
    }
    
}
