//
//  UIColor+Math.swift
//  Fields and Forces
//
//  Created by Cooper Knaak on 12/20/14.
//  Copyright (c) 2014 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import Cocoa
#endif

#if os(iOS)
public typealias ColorType = UIColor
#else
public typealias ColorType = NSColor
#endif

public extension ColorType {

    public class func violetColor() -> ColorType {
        return ColorType(red: 0.4, green: 0.0, blue: 0.8, alpha: 1.0)
    }//my personal purple color
    
    public class func darkRedColor() -> ColorType {
        return ColorType(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0)
    }//dark red
    
    public class func darkGreenColor() -> ColorType {
        return ColorType(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
    }//dark green
    
    public class func darkBlueColor() -> ColorType {
        return ColorType(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0)
    }//dark blue
    
    public convenience init(string:String) {
        
        let comps = string.components(separatedBy: ", ") as [NSString]
        let r = CGFloat(comps[0].floatValue)
        let g = CGFloat(comps[1].floatValue)
        let b = CGFloat(comps[2].floatValue)
        var a:CGFloat = 1.0
        
        if (comps.count >= 4) {
            a = CGFloat(comps[3].floatValue)
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }//initialize with a string
    
    public func getComponents() -> [CGFloat] {
        
        var red:CGFloat = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat = 0.0
        var alpha:CGFloat = 0.0

        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return [red, green, blue, alpha]
    }//get components
    
    public func getHSBComponents() -> [CGFloat] {
        var hue:CGFloat         = 0.0
        var saturation:CGFloat  = 0.0
        var brightness:CGFloat  = 0.0
        var alpha:CGFloat       = 0.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return [hue, saturation, brightness, alpha]
    }
    
    //Gets a string.
    //Initializing with the returned String
    //is guarunteed to return a ColorType
    //object that represents the same
    //color as this object
    public func getString() -> String {
        let comps = self.getComponents()
        return "\(comps[0]), \(comps[1]), \(comps[2]), \(comps[3])"
    }
    
    ///Returns either black or white, whichever would show up better when displayed over this color.
    public func absoluteContrastingColor() -> ColorType {
        var comps = self.getComponents()
        
        let brightness = comps[0] * 0.2 + comps[1] * 0.7 + comps[2] * 0.1
        if brightness > 0.5 {
            return ColorType.black
        } else {
            return ColorType.white
        }
    }
    
    ///Lightens or darkens only the RGB values (not the alpha).
    public func scaleRGB(_ factor:CGFloat) -> ColorType {
        let rgba = self.getComponents()
        return ColorType(red: rgba[0] * factor, green: rgba[1] * factor, blue: rgba[2] * factor, alpha: rgba[3])
    }
    
}// UIKit + Math


public func +(left:ColorType, right:ColorType) -> ColorType {
    let lComps = left.getComponents()
    let rComps = right.getComponents()
    
    return ColorType(red: lComps[0] + rComps[0], green: lComps[1] + rComps[1], blue: lComps[2] + rComps[2], alpha: lComps[3] + rComps[3])
}// +

public func -(left:ColorType, right:ColorType) -> ColorType {
    let lComps = left.getComponents()
    let rComps = right.getComponents()
    
    return ColorType(red: lComps[0] - rComps[0], green: lComps[1] - rComps[1], blue: lComps[2] - rComps[2], alpha: lComps[3] - rComps[3])
}// -

public func *(left:ColorType, right:ColorType) -> ColorType {
    let lComps = left.getComponents()
    let rComps = right.getComponents()
    
    return ColorType(red: lComps[0] * rComps[0], green: lComps[1] * rComps[1], blue: lComps[2] * rComps[2], alpha: lComps[3] * rComps[3])
}// *

public func /(left:ColorType, right:ColorType) -> ColorType {
    let lComps = left.getComponents()
    let rComps = right.getComponents()
    
    return ColorType(red: lComps[0] / rComps[0], green: lComps[1] / rComps[1], blue: lComps[2] / rComps[2], alpha: lComps[3] / rComps[3])
}// /

public func +=(left:inout ColorType, right:ColorType) {
    left = left + right
}// +=

public func -=(left:inout ColorType, right:ColorType) {
    left = left - right
}// -=

public func *=(left:inout ColorType, right:ColorType) {
    left = left * right
}// *=

public func /=(left:inout ColorType, right:ColorType) {
    left = left / right
}// /=


public func +(left:ColorType, right:CGFloat) -> ColorType {
     let lComps = left.getComponents()
    
    return ColorType(red: lComps[0] + right, green: lComps[1] + right, blue: lComps[2] + right, alpha: lComps[3] + right)
}// + scalar

public func -(left:ColorType, right:CGFloat) -> ColorType {
     let lComps = left.getComponents()
    
    return ColorType(red: lComps[0] - right, green: lComps[1] - right, blue: lComps[2] - right, alpha: lComps[3] - right)
}// - scalar

public func *(left:ColorType, right:CGFloat) -> ColorType {
     let lComps = left.getComponents()
    
    return ColorType(red: lComps[0] * right, green: lComps[1] * right, blue: lComps[2] * right, alpha: lComps[3] * right)
}// * scalar

public func /(left:ColorType, right:CGFloat) -> ColorType {
     let lComps = left.getComponents()
    
    return ColorType(red: lComps[0] / right, green: lComps[1] / right, blue: lComps[2] / right, alpha: lComps[3] / right)
}// / scalar

public func +=(left:inout ColorType, right:CGFloat) {
    left = left + right
}// +=

public func -=(left:inout ColorType, right:CGFloat) {
    left = left - right
}// -=

public func *=(left:inout ColorType, right:CGFloat) {
    left = left * right
}// *=

public func /=(left:inout ColorType, right:CGFloat) {
    left = left / right
}// /=


//Tuples
public typealias ColorTypeTuple4 = (CGFloat, CGFloat, CGFloat, CGFloat)

public func +(left:ColorType, right:ColorTypeTuple4) -> ColorType {
     let comps = left.getComponents()
    return ColorType(red: comps[0] + right.0, green: comps[1] + right.1, blue: comps[2] + right.2, alpha: comps[3] + right.3)
}

public func -(left:ColorType, right:ColorTypeTuple4) -> ColorType {
     let comps = left.getComponents()
    return ColorType(red: comps[0] - right.0, green: comps[1] - right.1, blue: comps[2] - right.2, alpha: comps[3] - right.3)
}

public func *(left:ColorType, right:ColorTypeTuple4) -> ColorType {
     let comps = left.getComponents()
    return ColorType(red: comps[0] * right.0, green: comps[1] * right.1, blue: comps[2] * right.2, alpha: comps[3] * right.3)
}

public func /(left:ColorType, right:ColorTypeTuple4) -> ColorType {
     let comps = left.getComponents()
    return ColorType(red: comps[0] / right.0, green: comps[1] / right.1, blue: comps[2] / right.2, alpha: comps[3] / right.3)
}

public func +(left:ColorTypeTuple4, right:ColorType) -> ColorType {
    return right + left
}

public func -(left:ColorTypeTuple4, right:ColorType) -> ColorType {
     let comps = right.getComponents()
    return ColorType(red: left.0 - comps[0], green: left.1 - comps[1], blue: left.2 - comps[2], alpha: left.3 - comps[3])
}

public func *(left:ColorTypeTuple4, right:ColorType) -> ColorType {
    return right * left
}

public func /(left:ColorTypeTuple4, right:ColorType) -> ColorType {
     let comps = right.getComponents()
    return ColorType(red: left.0 / comps[0], green: left.1 / comps[1], blue: left.2 / comps[2], alpha: left.3 / comps[3])
}

public func +=(left:inout ColorType, right:ColorTypeTuple4) {
    left = left + right
}

public func -=(left:inout ColorType, right:ColorTypeTuple4) {
    left = left - right
}

public func *=(left:inout ColorType, right:ColorTypeTuple4) {
    left = left * right
}

public func /=(left:inout ColorType, right:ColorTypeTuple4) {
    left = left / right
}
