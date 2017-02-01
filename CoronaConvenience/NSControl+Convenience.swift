//
//  NSControl+Convenience.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 1/22/17.
//  Copyright © 2017 Cooper Knaak. All rights reserved.
//

#if os(OSX)
import Cocoa

extension NSControl {
    
    public var boolValue:Bool {
        get {
            return self.integerValue != 0
        }
        set {
            self.integerValue = (newValue ? 1 : 0)
        }
    }
    
}
#endif
