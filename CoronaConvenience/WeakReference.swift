//
//  WeakReference.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 10/22/16.
//  Copyright © 2016 Cooper Knaak. All rights reserved.
//

import Foundation

public class WeakReference<T: AnyObject> {
    
    public private(set) weak var object:T? = nil
    
    public init(object:T?) {
        self.object = object
    }
    
}
