//
//  Bool+Convenience.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 6/20/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

import Foundation

extension Bool {
    
    public mutating func flip() {
        self = !self
    }
    
    ///Randomly returns true or false.
    public static func random() -> Bool {
        return arc4random() % 2 == 0
    }
    
}