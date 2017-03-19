//
//  NSLayoutConstraint+Convenience.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 3/18/17.
//  Copyright © 2017 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import Foundation
import UIKit

extension NSLayoutConstraint {
    
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    public func set(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
#endif
