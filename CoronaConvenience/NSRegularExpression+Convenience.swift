//
//  NSRegularExpression+Convenience.swift
//  EQParser
//
//  Created by Cooper Knaak on 2/1/16.
//  Copyright © 2016 Cooper Knaak. All rights reserved.
//

import Foundation

extension NSRange {
    
    public var range:CountableRange<Int> { return self.location..<self.location + self.length }
    
}

func +(lhs:Range<Int>, rhs:Int) -> CountableRange<Int> {
    return lhs.lowerBound+rhs..<lhs.upperBound+rhs
}

extension NSRegularExpression {
    
    public convenience init?(regex:String) {
        do {
            try self.init(pattern: regex, options: [])
        } catch {
            return nil
        }
    }
    
    public func matchesInString(_ string:String) -> [NSTextCheckingResult] {
        return self.matches(in: string, options: [], range: NSRange(location: 0, length: string.characterCount))
    }
    
    public func matchedStringsInString(_ string:String) -> [String] {
        return self.rangesInString(string).map() { string[$0] }
    }
    
    public func rangesInString(_ string:String) -> [CountableRange<Int>] {
        return self.matchesInString(string).map() { $0.range.range }
    }
}

extension String {
    
    public func matchesRegex(_ regex:String) -> Bool {
        guard let regExpress = try? NSRegularExpression(pattern: regex, options: []) else {
            return false
        }
        return regExpress.matchesInString(self).count > 0
    }
    
    public func replaceRegex(_ regex:String, with replaceStr:String) -> String {
        guard let expression = NSRegularExpression(regex: regex) else {
            return self
        }
        let matches = expression.matchesInString(self)
        
        var copiedString = self
        let _ = copiedString.replaceRanges(matches.map() { ($0.range.location..<$0.range.location+$0.range.length, replaceStr) })
        return copiedString
    }
    
    public mutating func replaceRegex(_ regex:String, with replacements:[String]) -> [String] {
        guard let expression = NSRegularExpression(regex: regex) else {
            return []
        }
        let matches = expression.matchesInString(self)
        
        var replacementIndex = -1
        let replaces = self.replaceRanges(matches.map() {
            replacementIndex += 1
            return ($0.range.location..<$0.range.location+$0.range.length, replacements.objectAtIndex(replacementIndex) ?? "?")
        })
        return replaces
    }
    
    public mutating func replaceRegex<T: IteratorProtocol>(_ regex:String, with withReplacements:T) -> [String] where T.Element == String {
        guard let expression = NSRegularExpression(regex: regex) else {
            return []
        }
        let matches = expression.matchesInString(self)
        var replacements = withReplacements
        
        var copiedString = self
        let replaces = copiedString.replaceRanges(matches.map() { ($0.range.location..<$0.range.location+$0.range.length, replacements.next() ?? "?") })
        return replaces
    }
    
    public func componentsSeperatedByRegex(_ str:String) -> [String] {
        guard let regex = NSRegularExpression(regex: str) else {
            return [self]
        }
        
        let ranges = regex.rangesInString(self)
        guard let firstRange = ranges.first else {
            return [self]
        }
        var strings:[String] = []
        strings.append(self[0..<firstRange.lowerBound])
        var previousEnd = firstRange.upperBound
        for (_, range) in ranges.enumerateSkipFirst() {
            strings.append(self[previousEnd..<range.lowerBound])
            previousEnd = range.upperBound
        }
        strings.append(self[previousEnd..<self.characterCount])
        return strings
    }
    
}