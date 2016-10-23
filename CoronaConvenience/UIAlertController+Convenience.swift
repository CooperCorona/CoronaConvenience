//
//  UIAlertController+Convenience.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 7/2/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit

extension UIAlertController {
    
    public convenience init(title:String?, message:String?, cancel:String, confirm:String, confirmHandler:((UIAlertAction?) -> Void)!) {
        
        self.init(title: title, message: message, preferredStyle: .alert)
        
        self.addCancelAction(title: cancel)
        self.addActionWithTitle(title: confirm, style: UIAlertActionStyle.default, handler: confirmHandler)
    }
    
    /**
    Initializes a UIAlertController object that displays a message and provides a button to dismiss.
    Used for displaying information, not for requesting anything.
    
    - parameter title: The title of the alert.
    - parameter message: The message of the alert.
    - parameter dismiss: The title of the button that dismisses the alert.
    */
    public convenience init(title:String?, message:String?, dismiss:String) {
        self.init(title: title, message: message, preferredStyle: .alert)
        
        self.addCancelAction(title: dismiss)
    }
    
    /**
    Creates a *UIAlertAction* object with parameters, then adds it to alert controller.
    
    - parameter title: The title of the action.
    - parameter style: The style of the action.
    - parameter handler: The handler to use when the corresponding button is clicked.
    */
    public func addActionWithTitle(title: String, style: UIAlertActionStyle, handler: ((UIAlertAction?) -> Void)!) {
        self.addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
    
    /**
    Creates a *UIAlertAction* object with *title* and .Cancel style, then adds it to alert controller.

    - parameter title: The title to use for the cancel action.
    */
    public func addCancelAction(title:String) {
        let cancelAction = UIAlertAction(title: title, style: .cancel) { action in }
        self.addAction(cancelAction)
    }
    
    ///Adds a text field with no configuration handler.
    public func addTextField() {
        self.addTextField() { _ in }
    }
    
    /**
    Gets the text of a specific text field.
    
    - parameter index: The index of the text field.
    - returns: The text of the text field at index *index*, or nil if there is no text field.
    */
    public func textAt(index:Int) -> String? {
        if let textFields = self.textFields {
            return object(textFields, atIndex: index)?.text
        } else {
            return nil
        }
    }
    
    ///Returns the text of the first text field, if it exists.
    public var firstText:String? { return self.textAt(index: 0) }
    
}
#endif
