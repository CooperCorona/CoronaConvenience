//
//  UnownedReference.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 10/22/16.
//  Copyright © 2016 Cooper Knaak. All rights reserved.
//

import Foundation

public class UnownedReference<T: AnyObject> {
    
    public unowned let object:T
    
    public init(object:T) {
        self.object = object
    }
    
}
