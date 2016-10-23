//
//  NSOperation+Convenience.swift
//  Gravity
//
//  Created by Cooper Knaak on 4/9/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

import Foundation

public extension Operation {
    
    public func addOptionalDependency(_ operation:Operation?) {
        
        if let o = operation {
            self.addDependency(o)
        }
        
    }//add optional dependency
    
}//Convenience
