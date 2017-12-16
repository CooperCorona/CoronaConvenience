//
//  String+Parsing.swift
//  DiscreteMath
//
//  Created by Cooper Knaak on 1/31/16.
//  Copyright © 2016 Cooper Knaak. All rights reserved.
//

import Foundation

extension String {

    public func repeated(_ amount:Int) -> String {
        if amount == 0 {
            return ""
        }
        var copiedStr = self
        for _ in 1..<amount {
            copiedStr += copiedStr
        }
        return copiedStr
    }

    public func removeParentheses() -> String {
        if self.hasPrefix("(") && self.hasSuffix(")") {
            return self[1..<self.characterCount-1]
        } else {
            return self
        }
    }

    public func rangesOfParentheses() -> [CountableClosedRange<Int>] {
        var ranges:[CountableClosedRange<Int>] = []
        var parenthesesCount = 0
        var openingIndex = 0
        for (i, char) in self.enumerated() {
            if char == "(" {
                parenthesesCount += 1
                if parenthesesCount == 1 {
                    openingIndex = i
                }
            } else if char == ")" {
                parenthesesCount -= 1
                if parenthesesCount == 0 && openingIndex + 1 < i {
                    ranges.append(openingIndex+1...i-1)
                }
            }
        }
        return ranges
    }

    public mutating func replaceRange(_ range:CountableRange<Int>, with replaceStr:String) {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        self.replaceSubrange(start..<end, with: replaceStr)
    }
    /*
    public mutating func replaceRanges(ranges:[(Range<Int>, String)]) {
        var replaceOffset = 0
        for (range, str) in ranges {
            let offsetRange = (range.startIndex + replaceOffset)..<(range.endIndex + replaceOffset)
            self.replaceRange(offsetRange, with: str)
            replaceOffset += range.startIndex - range.endIndex + str.characterCount
        }
    }
    */
    public mutating func replaceRanges(_ ranges:[(CountableRange<Int>, String)]) -> [String] {
        var replacedStrings:[String] = []
        var replaceOffset = 0
        for (range, str) in ranges {
            let offsetRange:CountableRange = (range.lowerBound + replaceOffset)..<(range.upperBound + replaceOffset)
            replacedStrings.append(self[offsetRange])
            self.replaceRange(offsetRange, with: str)
            replaceOffset += range.lowerBound - range.upperBound + str.characterCount
        }
        return replacedStrings
    }

    public mutating func replaceRanges<T: IteratorProtocol>(_ ranges:[CountableRange<Int>], replacement withReplacement:T) -> [String] where T.Element == String {
        var replacement = withReplacement
        var replacedStrings:[String] = []
        var replaceOffset = 0
        for range in ranges {
            let str = replacement.next() ?? "?"
            let offsetRange = (range.lowerBound + replaceOffset)..<(range.upperBound + replaceOffset)
            replacedStrings.append(self[offsetRange])
            self.replaceRange(offsetRange, with: str)
            replaceOffset += range.lowerBound - range.upperBound + str.characterCount
        }
        return replacedStrings
    }

    public mutating func replaceRanges(_ ranges:[CountableRange<Int>], with replaceStrs:[String]) {
        let _ = self.replaceRanges(ranges.iterateWith(replaceStrs).map() { $0 })
    }
}
