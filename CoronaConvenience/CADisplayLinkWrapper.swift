//
//  CADisplayLinkWrapper.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 8/17/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit

/**
A wrapper around CADisplayLink. Because CADisplayLink
retains its target, it causes retain cycles (usually in
my view controllers). This class mimics a weakly-retained
display link. It implements all display link functionality,
so you can smoothly replace any instance of CADisplayLink
with CADisplayLinkWrapper.
*/
public class CADisplayLinkWrapper: NSObject {
    
    // MARK: - Types
    
    public class InternalWrapper: NSObject
    {
        unowned let owner:CADisplayLinkWrapper
        lazy var displayLink:CADisplayLink = CADisplayLink(target: self, selector: #selector(InternalWrapper.performAction(_:)))
        
        private init(owner: CADisplayLinkWrapper) {
            self.owner = owner
            
            super.init()
        }
        
        func performAction(sender:CADisplayLink) {
            self.owner.handler?(sender)
        }
        
        deinit {
            self.displayLink.invalidate()
        }
        
    }
    
    // MARK: - Properties
    
    private lazy var wrapper:InternalWrapper = InternalWrapper(owner: self)
    ///The handler to be invoked whenever the display link is fired.
    public var handler:((CADisplayLink) -> Void)? = nil
    
    ///How many frames must elapse between display link fires.
    public var frameInterval:Int {
        get {
            return self.wrapper.displayLink.frameInterval
        }
        set {
            self.wrapper.displayLink.frameInterval = newValue
        }
    }
    
    ///How many times the display link fires per second.
    ///Equivalent to
    ///  60 / frameInterval
    public var framesPerSecond:Int {
        get {
            return 60 / self.frameInterval
        }
        set {
            self.frameInterval = 60 / newValue
        }
    }
    
    ///When true the display link is prevented from firing.
    public var paused:Bool {
        get {
            return self.wrapper.displayLink.paused
        }
        set {
            self.wrapper.displayLink.paused = newValue
        }
    }
    
    // MARK: - Setup
    
    /**
    Initializes with a handler.
    
    - parameter handler: An optional handler to be invoked when the display link fires.
    */
    public init(handler:((CADisplayLink) -> Void)?) {
        self.handler = handler
        
        super.init()
    }
    
    ///Initializes with a nil handler.
    public convenience override init() {
        self.init(handler: nil)
    }
    
    /**
    Adds the display link to a run loop for a given mode.
    
    - parameter runLoop: The run loop to be added to.
    - parameter mode: The mode in which the display link will fire.
    */
    public func addToRunLoop(runLoop: NSRunLoop, forMode mode:String) {
        self.wrapper.displayLink.addToRunLoop(runLoop, forMode: mode)
    }
    
    ///Removes the display link from a given run loop for a given mode.
    public func removeFromRunLoop(runLoop: NSRunLoop, forMode mode:String) {
        self.wrapper.displayLink.removeFromRunLoop(runLoop, forMode: mode)
    }
    
    ///Adds to NSRunLoop.mainLoop() in NSRunLoopCommonModes.
    public func addToRunLoopDefault() {
        self.wrapper.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    // MARK: - Logic
    
    ///Invalidates the display link.
    public func invalidate() {
        self.wrapper.displayLink.invalidate()
    }
    
    // MARK: - Deinitialization
    
    deinit {
        self.wrapper.displayLink.invalidate()
    }
    
}
#endif