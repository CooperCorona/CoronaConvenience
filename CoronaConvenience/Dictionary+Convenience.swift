//
//  Dictionary+Convenience.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 10/19/17.
//  Copyright © 2017 Cooper Knaak. All rights reserved.
//

import Foundation

extension Dictionary {
    
    public func get(keys:[Key]) -> [Value] {
        return keys.flatMap() { self[$0] }
    }
    
}
