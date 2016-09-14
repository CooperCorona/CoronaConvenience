//
//  Math.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 6/13/16.
//  Copyright © 2016 Cooper Knaak. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#else
import Cocoa
#endif

public func quadraticFormulaA(a:CGFloat, b:CGFloat, c:CGFloat) -> (negative:CGFloat, positive:CGFloat)? {
    let radical = b * b - 4 * a * c
    guard radical >= 0.0 else {
        return nil
    }
    let positive = (-b + sqrt(radical)) / (2.0 * a)
    let negative = (-b - sqrt(radical)) / (2.0 * a)
    return (negative, positive)
}

func getRetinaScale() -> CGFloat {
    #if os(iOS)
    if (UIScreen.mainScreen().respondsToSelector(Selector("nativeScale"))) {
        let nativeScale = UIScreen.mainScreen().nativeScale
        return (nativeScale > 0.0) ? nativeScale : 1.0
    } else if (UIScreen.mainScreen().respondsToSelector(#selector(UIScreen.displayLinkWithTarget(_:selector:)))) {
        //'scale' property only works correctly
        //after 'displayLinkWithTarget:selector:
        //was introduced
        return UIScreen.mainScreen().scale
    }
    
    return 1.0
    #else
    return 1.0
    #endif
}