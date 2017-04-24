//
//  ColorUtils.swift
//  CoronaConvenience
//
//  Created by Cooper Knaak on 4/20/17.
//  Copyright © 2017 Cooper Knaak. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif

public enum ColorChannel: Int {
    case red    = 0
    case green  = 1
    case blue   = 2
    case alpha  = 3
}

extension ColorType {
    
    public var channels:[ColorChannel:CGFloat] {
        let comps = self.getComponents()
        return [
            .red: comps[0],
            .green: comps[1],
            .blue: comps[2],
            .alpha: comps[3]
        ]
    }
    
    public var intChannels:[ColorChannel:Int] {
        get {
            let comps = self.getComponents()
            return [
                .red: Int(comps[0] * 255.0),
                .green: Int(comps[1] * 255.0),
                .blue: Int(comps[2] * 255.0),
                .alpha: Int(comps[3] * 255.0)
            ]
        }
    }
    
    public subscript(channel:ColorChannel) -> CGFloat {
        get {
            return self.channels[channel]!
        }
    }
    
    public func int(for channel:ColorChannel) -> Int {
        return self.intChannels[channel]!
    }
    
    public func with(channels:[ColorChannel:CGFloat]) -> ColorType {
        let selfChannels = self.channels
        return ColorType(red: channels[.red] ?? selfChannels[.red]!, green: channels[.green] ?? selfChannels[.green]!, blue: channels[.blue] ?? selfChannels[.blue]!, alpha: channels[.alpha] ?? selfChannels[.alpha]!)
    }
    
    public func with(value:CGFloat, for channel:ColorChannel) -> ColorType {
        return self.with(channels: [channel:value])
    }
    
    public func with(channels:[ColorChannel:Int]) -> ColorType {
        let selfChannels = self.intChannels
        let red = channels[.red] ?? selfChannels[.red]!
        let green = channels[.green] ?? selfChannels[.green]!
        let blue = channels[.blue] ?? selfChannels[.blue]!
        let alpha = channels[.alpha] ?? selfChannels[.alpha]!
        return ColorType(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    public func with(value:Int, for channel:ColorChannel) -> ColorType {
        return self.with(channels: [channel:value])
    }
    
}
