//
//  UILabel+Creation.swift
//  Better Breeding
//
//  Created by Cooper Knaak on 12/6/14.
//  Copyright (c) 2014 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit

public struct LabelContainer {
    
    public let text:String
    public let font:UIFont
    public let textColor:UIColor
    
    public init(text:String) {
        
        self.init(text:text, font:LabelContainer.defaultFont, textColor:UIColor.blackColor())
        
    }//initialize
    
    public init(text:String, font:UIFont, textColor:UIColor = UIColor.blackColor()) {
        
        self.text = text
        self.font = font
        self.textColor = textColor
        
    }//initialize
    
    
    public static var defaultFont:UIFont {
        struct Static {
            static let instance:UIFont = UIFont(name:"Arial", size:32.0)!
        }//static instance
        return Static.instance
    }//shared instance class
    
}//label container

//Creation
public extension UILabel {
    
    public class func labelWithText(text:String) -> UILabel {
        
        return UILabel.labelWithAttributes(LabelContainer(text:text))
        
    }//create label
    
    public class func labelWithAttributes(lContainer:LabelContainer) -> UILabel {
        
        let textAsNSString = NSString(string: lContainer.text)
        let size = textAsNSString.sizeWithAttributes([NSFontAttributeName:lContainer.font])
        
        let label = UILabel()
        
        label.frame = CGRect(origin: CGPointZero, size: size)
        label.text = lContainer.text
        label.textColor = lContainer.textColor
        label.textAlignment = NSTextAlignment.Center
        label.font = lContainer.font
        
        return label
    }//initialize
    
    public convenience init(text:String, font:UIFont, color:UIColor = UIColor.blackColor()) {
        
        let textAsNSString = NSString(string: text)
        let size = textAsNSString.sizeWithAttributes([NSFontAttributeName:font])
        
        self.init(frame: CGRect(size: size))
        
        self.text = text
        self.textColor = color
        self.textAlignment = .Center
        self.font = font
    }
    
}//UILabel + Creation

//Convenience
public extension UILabel {
    
    public func changeFrameAndText(text:String) {
        
        let size = (text as NSString).sizeWithAttributes([NSFontAttributeName:self.font])
        
        self.text = text
        self.frame = CGRect(center: self.center, size: size)
        
        var numberOfLines = 1
        for cur in text.unicodeScalars {
            if (cur == "\n") {
                numberOfLines += 1
            }
        }
        self.numberOfLines = numberOfLines
    }//set 'text' and apply correct frame
    
    public func changeFrameForFont(font:UIFont) {
        
        self.font = font
        let size = (self.text! as NSString).sizeWithAttributes([NSFontAttributeName:font])
        
        self.frame = CGRect(center: self.center, size: size)
    }//set 'font' and apply correct frame
    
    public func sizeToFitCentered() {
        let centerPoint = self.center
        self.sizeToFit()
        self.center     = centerPoint
    }
    
}//UILabel + Convenience
#endif