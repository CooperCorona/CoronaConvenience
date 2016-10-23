//
//  NSObject+Convenience.swift
//  Gravity
//
//  Created by Cooper Knaak on 2/23/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif


//NSObject + Convenience
//Collection of methods designed for convenience.
public extension NSObject {
    
    public class func dispatchAfter(_ seconds:CGFloat, onQueue queue:DispatchQueue, withBlock block:@escaping ()->()) {
        
        let dTime = DispatchTime.now() + Double(Int64(CGFloat(NSEC_PER_SEC) * seconds)) / Double(NSEC_PER_SEC)
        
        queue.asyncAfter(deadline: dTime, execute: block)
        
    }//dispatch after
    
    public class func dispatchAfter(_ seconds:CGFloat, withBlock block:@escaping ()->()) {
        
        NSObject.dispatchAfter(seconds, onQueue: DispatchQueue.main, withBlock: block)
        
    }//dispatch after (on main thread)
    
    public class func dispatchAsyncMain(_ block:@escaping ()->()) {
        
        DispatchQueue.main.async(execute: block)
        
    }//dispatch asynchronously on main thread
    
}//Convenience
