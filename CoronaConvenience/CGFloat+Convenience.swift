//
//  CGFloat+Convenience.swift
//  MatTest
//
//  Created by Cooper Knaak on 2/8/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#else
import Cocoa
#endif

infix operator ~=: ComparisonPrecedence
public func ~=(left:CGFloat, right:CGFloat) -> Bool {
    
    let epsilon:CGFloat = 0.001
    
    return abs(left - right) <= epsilon
}//about equals operator

//Optionally Assign Operator:
//If value to assign is nil,
//then no assignment happens.
//If the value exists, then
//the value is assigned
infix operator ??=: AssignmentPrecedence
public func ??=<T>(lhs:inout T, rhs:T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}
/*
infix operator !~= { precedence 130 }
func !~=<T: ApproximatelyEquatable_CC>(left:T, right:T) -> Bool {
return (left ~= right)
}
*/

extension CGFloat {
    
    public mutating func decrementTowardsZeroBy(_ decrementValue:CGFloat) {
        
        if (self > 0.0) {
            self -= decrementValue
        } else {
            self += decrementValue
        }
        
        if (abs(self) <= decrementValue / 2.0) {
            self = 0.0
        }
    }//decrement towards zero by
    
    public func nearestTo(_ values:(CGFloat, CGFloat)) -> CGFloat {
        
        if (abs(self - values.0) < abs(self - values.1)) {
            return values.0
        } else {
            return values.1
        }
        
    }//get value that is nearest to this value
    
    public func signOf() -> CGFloat {
        if self < 0.0 {
            return -1.0
        } else if self > 0.0 {
            return +1.0
        } else {
            return 00.0
        }
    }
    
    public func floorTowardZero() -> CGFloat {
        return floor(abs(self)) * self.signOf()
    }
    
    public func ceilTowardZero() -> CGFloat {
        return ceil(abs(self)) * self.signOf()  
    }
    
    public func isBetween(_ lower:CGFloat, and upper:CGFloat) -> Bool {
        /*
         l<s | s<u | ==
         T     T     T
         T     F     F
         F     T     F
         F     F     T
         */
        return (lower < self || lower ~= self) == (self < upper || upper ~= self)
    }
    
    /**
     Converts this value (representing an angle) in the range of [-π, π] to [0, 2π].
     - returns: The value of self in the range of [0, 2π].
     */
    public func convertNegativeAngleRangeToPositive() -> CGFloat {
        if self < 0.0 {
            return 2.0 * CGFloat(M_PI) + self
        } else {
            return self
        }
    }
    
    /**
     Converts this value (representing an angle) in the range of [0, 2π] to [-π, π].
     - returns: The value of self in the range of [-π, π].
     */
    public func convertPositiveAngleRangeToNegative() -> CGFloat {
        if self > CGFloat(M_PI) {
            return self - 2.0 * CGFloat(M_PI)
        } else {
            return self
        }
    }
    
}//CGFloat

public func positions(_ count:Int, ofSize objectSize:CGFloat, inSize windowSize:CGFloat) -> [CGFloat] {
    let buffer = (windowSize - CGFloat(count) * objectSize) / CGFloat(count + 1)
    var positions:[CGFloat] = []
    for i in 0..<count {
        let fi = CGFloat(i)
        positions.append(buffer * (fi + 1.0) + objectSize * (fi + 0.5))
    }
    return positions
}
