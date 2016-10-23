//
//  NSFileManager+Convenience.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 8/30/15.
//  Copyright (c) 2015 Cooper Knaak. All rights reserved.
//

import Foundation

extension FileManager {
    
    /**
    Gets all files of a bundle with a given file extension.
    
    - parameter type: The file extension (png, pdf, vsh)
    - parameter removeExtensions: Whether to remove the file extensions in the returned array. Default value is true.
    - returns: An array of all file paths with a given extension in the bundle.
    */
    public func allFilesOfType(_ type:String, removeExtensions:Bool = true) -> [URL] {
        var paths:[URL] = []
        let omniSwiftBundle = Bundle.allFrameworks.filter() { $0.bundlePath.hasSuffix(("OmniSwift.framework")) } .objectAtIndex(0)
//        if let path = NSBundle.mainBundle().resourcePath, let enumerator = self.enumeratorAtPath(path) {
        if let path = omniSwiftBundle?.resourcePath, let enumerator = self.enumerator(atPath: path) {
            while let currentPath = enumerator.nextObject() as? String, let currentURL = URL(string: currentPath) {
                if currentURL.pathExtension == type {
                    paths.append(currentURL)
                }
            }
        }
        
        if removeExtensions {
            return paths.flatMap() { $0.deletingPathExtension() }
        } else {
            return paths
        }
    }
    
    /**
    Gets all files of a bundle with given file extensions.
    
    - parameter type: An array containing the desired file extensions (png, pdf, vsh)
    - parameter removeExtensions: Whether to remove the file extensions in the returned dictionary. Default value is true.
    - returns: An dictionary of all file paths with given extensions in the bundle.
    */
    public func allFilesOfTypes(_ types:[String], removeExtensions:Bool = true) -> [String:String] {
        
        var paths:[String:String] = [:]
        
        if let path = Bundle.main.resourcePath, let enumerator = self.enumerator(atPath: path) {
            while let currentPath = enumerator.nextObject() as? String, let currentURL = URL(string: currentPath) {
                let pathExtension = currentURL.pathExtension
                if let index = types.index(of: pathExtension) {
                    let key = (removeExtensions ? currentURL.deletingPathExtension().absoluteString : currentURL.absoluteString)
                    paths[key] = types[index]
                }
            }
        }
        
        return paths
    }
    
    public func documentsDirectory() -> URL? {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
    }
    
    public class func fileExistsInDocuments(_ file:String, fileExtension:String) -> Bool {
        let path = UniversalSaverBase.pathForFile(file, fileExtension: fileExtension)
        return FileManager.default.fileExists(atPath: path)
    }
}
