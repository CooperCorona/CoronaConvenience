//
//  UIViewController+Geometry.swift
//  MatTest
//
//  Created by Cooper Knaak on 1/19/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit

public extension UIViewController {
    
    public func locationFromTouches(touches:NSSet) -> CGPoint {
        return self.view.locationFromTouches(touches: touches)
        /*
            if (touches.count <= 0) {
                return CGPoint.zero
            }
        
        var location = CGPoint.zero
       
        touches.enumerateObjectsUsingBlock() {
            if let touch = $0.0 as? UITouch {
                location += touch.locationInView(self.view)
            }
        }
        
        return location / CGFloat(touches.count)
        */
    }
    
    
    public var frameWithoutNavBar:CGRect {
        let vSize   = self.view.frame.size
        let navH    = self.topLayoutGuide.length
        return CGRect(x: 0.0, y: navH, width: vSize.width, height: vSize.height - navH)
    }
    
    public func getFrame() -> CGRect {
        return self.frameForOrientation(orientation: self.interfaceOrientation)
    }
    
    public func frameForOrientation(orientation:UIInterfaceOrientation) -> CGRect {
        let vSize = self.view.frame.size
        
        let minSize = min(vSize.width, vSize.height)
        let maxSize = max(vSize.width, vSize.height)
        
        if (orientation.isLandscape) {
            return CGRect(x: 0, y: 0, width: maxSize, height: minSize)
        } else {
            return CGRect(x: 0, y: 0, width: minSize, height: maxSize)
        }
    }
    
    public func navBarHeight() -> CGFloat {
        
        let statusH = UIApplication.shared.statusBarFrame.size.height
        
        if let navCon = self.navigationController {
            if (!navCon.isNavigationBarHidden) {
                return navCon.navigationBar.frame.size.height + statusH
            }
            
        }
        
        return statusH
    }//get height (or lack thereof) of navigation bar
    
}
#endif
