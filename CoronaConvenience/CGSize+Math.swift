//
//  CGSize+Math.swift
//  InverseKinematicsTest
//
//  Created by Cooper Knaak on 10/21/14.
//  Copyright (c) 2014 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif


//Operations

public func +(left:CGSize, right:CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}//plus

public func -(left:CGSize, right:CGSize) -> CGSize {
    return CGSize(width: left.width - right.width, height: left.height - right.height)
}//minus

public func *(left:CGSize, right:CGSize) -> CGSize {
    return CGSize(width: left.width * right.width, height: left.height * right.height)
}//times

public func /(left:CGSize, right:CGSize) -> CGSize {
    return CGSize(width: left.width / right.width, height: left.height / right.height)
}//divide

//Equals

public func +=(left:inout CGSize, right:CGSize) {
    left = left + right
}//plus equals

public func -=(left:inout CGSize, right:CGSize) {
    left = left - right
}//minus equals

public func *=(left:inout CGSize, right:CGSize) {
    left = left * right
}//times equals

public func /=(left:inout CGSize, right:CGSize) {
    left = left / right
}//divide equals

//Scalars

public func +(left:CGSize, right:CGFloat) -> CGSize {
    return CGSize(width: left.width + right, height: left.height + right)
}//plus scalar

public func +(right:CGFloat, left:CGSize) -> CGSize {
    return CGSize(width: left.width + right, height: left.height + right)
}//plus scalar

public func -(left:CGSize, right:CGFloat) -> CGSize {
    return CGSize(width: left.width - right, height: left.height - right)
}//minus scalar

public func -(right:CGFloat, left:CGSize) -> CGSize {
    return CGSize(width: left.width - right, height: left.height - right)
}//minus scalar

public func *(left:CGSize, right:CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}//times scalar

public func *(right:CGFloat, left:CGSize) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}//times scalar

public func /(left:CGSize, right:CGFloat) -> CGSize {
    return CGSize(width: left.width / right, height: left.height / right)
}//divide scalar

public func /(right:CGFloat, left:CGSize) -> CGSize {
    return CGSize(width: left.width / right, height: left.height / right)
}//divide scalar

//Scalar equals

public func +=(left:inout CGSize, right:CGFloat) {
    left = left + right
}//add equals scalar

public func -=(left:inout CGSize, right:CGFloat) {
    left = left - right
}//minus equals scalar

public func *=(left:inout CGSize, right:CGFloat) {
    left = left * right
}//times equals scalar

public func /=(left:inout CGSize, right:CGFloat) {
    left = left / right
}//divide equals scalar


public extension CGSize {
    
    public var center:CGPoint { return CGPoint(x: self.width / 2.0, y: self.height / 2.0) }
    
    public var maximum:CGFloat { return max(self.width, self.height) }
    public var minimum:CGFloat { return min(self.width, self.height) }
    
    public var portrait:Bool    { return self.width < self.height }
    public var landscape:Bool   { return self.width > self.height }
    
    public init(square:CGFloat) {
        self.init(width: square, height: square)
    }//initialize as square
    
    public func getCGPoint() -> CGPoint {
        
        return CGPoint(x: width, y: height)
        
    }//get as CGPoint

    public func flip() -> CGSize {
        return CGSize(width: self.height, height: self.width)
    }
    
}//size
/*
public extension CGSize: FloatLiteralConvertible {
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(square: CGFloat(value))
    }
}
*/
