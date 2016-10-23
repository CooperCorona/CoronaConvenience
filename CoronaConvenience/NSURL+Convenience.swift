//
//  NSURL+Convenience.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 11/25/15.
//  Copyright © 2015 Cooper Knaak. All rights reserved.
//

import Foundation

extension URL {
    
    public static func URLForPath(_ path:String, pathExtension:String) -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentURL = URL(fileURLWithPath: paths[0] as String, isDirectory: true)
        return documentURL.appendingPathComponent(path).appendingPathExtension(pathExtension)
    }
    
}
