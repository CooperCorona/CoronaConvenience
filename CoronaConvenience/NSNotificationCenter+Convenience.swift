//
//  NSNotificationCenter+Convenience.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 11/10/15.
//  Copyright © 2015 Cooper Knaak. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#else
import Cocoa
#endif

extension NotificationCenter {
    
    public func addObserver(_ observer:AnyObject, name: String, selector: Selector) {
        self.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    public class func addObserver(_ observer:AnyObject, name: String, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    public class func removeObserver(_ observer:AnyObject, name: String) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    public class func removeObserver(_ observer:AnyObject) {
        NotificationCenter.default.removeObserver(observer)
    }
    
}
