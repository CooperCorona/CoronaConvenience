//
//  RegexMatch.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 11/7/16.
//  Copyright © 2016 Cooper Knaak. All rights reserved.
//

import Foundation

public struct RegexMatch: CustomStringConvertible {
    
    public let range:NSRange
    public let match:String
    public let groups:[String]
    
    public var description:String { return self.match }
    
    public init(range:NSRange, match:String, groups:[String]) {
        self.range = range
        self.match = match
        self.groups = groups
    }
    
    public subscript(index:Int) -> String {
        return self.groups[index]
    }
    
}
