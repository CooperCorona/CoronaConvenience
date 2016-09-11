//
//  GameKitHelper.swift
//  Fields and Forces
//
//  Created by Cooper Knaak on 1/16/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import GameKit

public class GameKitHelper: NSObject {

    
    private var available = false
    private var authenticated = false
    private var enabled = false
    public var isAvailable:Bool { return self.available }
    public var isAuthenticated:Bool { return self.authenticated }
    public var isEnabled:Bool { return self.enabled }
    
    private var authenticationBlock:(() -> ())? = nil
    
    public override init() {
        
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameKitHelper.authenticationChanged(_:)), name: GKPlayerAuthenticationDidChangeNotificationName, object: nil)
        
        self.available = self.gameKitIsAvailable()
        
    }//initialize
    
    public func gameKitIsAvailable() -> Bool {
        
        let gameClass:AnyClass? = NSClassFromString("GKLocalPlayer")
        
        let version = "4.1"
        let systemVersion = UIDevice.currentDevice().systemVersion
        
        let versionIsSupported = systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch, range: nil, locale: nil) != NSComparisonResult.OrderedAscending
        
        return gameClass !== nil && versionIsSupported
    }//check if game kit is available
    
    
    public func authenticateUserWithHandler(handler:() -> ()) {
        
        if (!self.available) {
            return
        }
        
        self.authenticationBlock = handler
        
        if (!GKLocalPlayer.localPlayer().authenticated) {
            GKLocalPlayer.localPlayer().authenticateHandler = self.authenticationComplete
        }
        
    }//authenticate user with handler
    
    public func authenticationComplete(viewController:UIViewController?, error:NSError?) {
        
        let lPlayer = GKLocalPlayer.localPlayer()
        
        if (lPlayer.authenticated) {
            self.authenticated = true
            self.enabled = true
        } else if let vCont = viewController {
            self.presentViewController(vCont)
        } else {
            self.authenticated = false
            self.enabled = false
        }
        
        if let handler = self.authenticationBlock {
            handler()
        }
    }//authentication complete
    
    private func getRootViewController() -> UIViewController? {
        return UIApplication.sharedApplication().keyWindow?.rootViewController
    }
    
    public func presentViewController(controller:UIViewController) {
        
        if let rootController = self.getRootViewController() {
            rootController.presentViewController(controller, animated: true, completion: nil)
        }
        
    }//present view controller
    
    public func authenticationChanged(notification:NSNotification) {
        
    }//authentication changed
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


//GameKitHelper + SharedInstance
extension GameKitHelper {
    
    public class var sharedInstance:GameKitHelper {
        struct StaticInstance {
            static let instance = GameKitHelper()
        }
        
        return StaticInstance.instance
    }

    public class var available:Bool { return GameKitHelper.sharedInstance.isAvailable }
    public class var authenticated:Bool { return GameKitHelper.sharedInstance.isAuthenticated }
    public class var enabled:Bool { return GameKitHelper.sharedInstance.isEnabled }
    
}//Shared Instance


//Achievements
extension GameKitHelper {
    
    ///Remember that percent is out of 100 %, so complete is 100.00.
    public func submitAchievement(achieveID:NSString, percent:Double = 100.00) {
        
        self.submitAchievements([(achieveID, percent)])
        
    }//submit an achievement
    
    public func submitAchievements(achieveIDsAndPercents:[(NSString, Double)]) {
        
        if (!self.available || !self.enabled) {
            return
        }
        
        var achievements:[GKAchievement] = []
        for (identifier, percent) in achieveIDsAndPercents {
            
            let achievement = GKAchievement(identifier: identifier as String)
            achievement.percentComplete = percent
            achievement.showsCompletionBanner = true
            
            achievements.append(achievement)
        }
        
        GKAchievement.reportAchievements(achievements) { (error:NSError?) in
            //Can't pass nil, so I just leave this empty
            if let error = error {
                print("Error:\n\(error)")
            }
        }
        
    }//submit multiple achievements
    
}// Achievements
#endif