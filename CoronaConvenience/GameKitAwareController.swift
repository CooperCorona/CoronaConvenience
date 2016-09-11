//
//  GameKitAwareController.swift
//  Gravity
//
//  Created by Cooper Knaak on 5/7/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit
import GameKit

public class GameKitAwareController: UIViewController, GKGameCenterControllerDelegate {

    // MARK: - Properties
    /**
Set this property to the button you want to
have show the game center controller.
*/
    public var gameCenterControllerButton:UIButton? = nil
    public var gameController:GKGameCenterViewController? = nil
    public var defaultGameViewState = GKGameCenterViewControllerState.Achievements
    
    // MARK: - Setup
    
    public func authenticateGameKit() {
        self.gameCenterControllerButton?.alpha = 0.0
        GameKitHelper.sharedInstance.authenticateUserWithHandler() {
            
            if (GameKitHelper.authenticated) {
                self.setupGameController()
            }
            self.animateGameCenterButton(GameKitHelper.authenticated)
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameKitAwareController.authenticationChanged(_:)), name: GKPlayerAuthenticationDidChangeNotificationName, object: nil)
    }//authenticate game kit
    
    public func setupGameController() {
        
        if (self.gameController === nil) {
            self.gameController = GKGameCenterViewController()
            self.gameController?.gameCenterDelegate = self
        }
        
    }//setup game controller
    
    public func animateGameCenterButton(enabled:Bool) {
        
        if let gameCenterButton = self.gameCenterControllerButton {
            
            let duration:NSTimeInterval = 0.5
            if (enabled && gameCenterButton.alpha ~= 0.0) {
                
                gameCenterButton.alpha = 0.0
                UIView.animateEaseInOutWithDuration(duration) { /*[unowned self] in*/
                    gameCenterButton.alpha = 1.0
                }
                
            } else if (!enabled && gameCenterButton.alpha ~= 1.0) {
                
                gameCenterButton.alpha = 1.0
                UIView.animateEaseInOutWithDuration(duration) { /*[unowned self] in*/
                    gameCenterButton.alpha = 0.0
                }
            }
            
        }
        
    }//animate game center button
    
    public func gameCenterControllerButtonPressed(sender:UIButton?) {
        
        if let gCont = self.gameController {
            gCont.viewState = self.defaultGameViewState
            self.navigationController?.presentViewController(gCont, animated: true, completion: nil)
        }
        
    }//show controller
    
    public func authenticationChanged(notification:NSNotification) {
        self.animateGameCenterButton(GameKitHelper.enabled)
    }//game center authentication changed
    
    public func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
    }//dismiss game center controller
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: GKPlayerAuthenticationDidChangeNotificationName, object: nil)
    }
    
}
#endif