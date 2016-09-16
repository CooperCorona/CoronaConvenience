//
//  UniversalSaverBase.swift
//  Fields and Forces
//
//  Created by Cooper Knaak on 12/30/14.
//  Copyright (c) 2014 Cooper Knaak. All rights reserved.
//

import Foundation

open class UniversalSaverBase: NSObject {
    
    open let fileName:String
    open let fileExtension:String
    open let fileDirectory:String?
    
    open var path:String { return UniversalSaverBase.pathForFile(self.fileName, fileExtension:self.fileExtension, directory:self.fileDirectory) }
    
    public init(file:String, fileExtension:String, directory:String?) {
        
        self.fileName = file
        self.fileExtension = fileExtension
        self.fileDirectory = directory
        
        if let directory = self.fileDirectory {
            UniversalSaverBase.createDirectoryAtPath(directory)
        }
        
        super.init()
        
    }//initialize
    
    
    open func save() -> Bool {
        
        let path = self.path
        
        let mData = NSMutableData()
        let archive = NSKeyedArchiver(forWritingWith: mData)
        
        self.saveWithArchiver(archive)
        
        archive.finishEncoding()
        return mData.write(toFile: path, atomically: true)
    }//save
    
    open func load() -> Bool {
        
        let path = self.path
        let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        
        if let validData = data {
            
            let unarchive = NSKeyedUnarchiver(forReadingWith: validData)
            
            self.loadWithArchiver(unarchive)
            
            unarchive.finishDecoding()
            
            return true
        } else {
            return false
        }
        
    }//load
    
    open func saveWithArchiver(_ archive:NSKeyedArchiver) {
        
    }//save with NSKeyedArchiver
    
    open func loadWithArchiver(_ unarchive:NSKeyedUnarchiver) {
        
    }//load with NSKeyedUnarchiver
    
    // MARK: - Class Methods
    
    open class func pathForFile(_ file:String, fileExtension:String, directory:String? = nil) -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectoryPath = paths[0] as NSString
        var filePath = documentDirectoryPath
        
        if let validDirectory = directory {
            filePath = filePath.appendingPathComponent(validDirectory) as NSString
        }
        
        filePath = filePath.appendingPathComponent(file) as NSString
        filePath = filePath.appendingPathExtension(fileExtension)! as NSString
        
        return filePath as String
    }//get path in documents directory
    
    //Checks both documents directory and main bundle
    open class func fileExistsAtPath(_ file:String, fileExtension:String, directory:String? = nil) -> Bool {
        
        let documentsPath = UniversalSaverBase.pathForFile(file, fileExtension: fileExtension, directory: directory)
        if (FileManager.default.fileExists(atPath: documentsPath)) {
            return true
        } else {
            return Bundle.main.path(forResource: file, ofType: fileExtension) != nil
        }
        
    }//check if file exists in documents directory or in main bundle
    
    open class func pathForFileInDocumentsOrBundle(_ file:String, fileExtension:String, directory:String? = nil) -> String? {
        
        let documentsPath = UniversalSaverBase.pathForFile(file, fileExtension: fileExtension, directory: directory)
        
        if (FileManager.default.fileExists(atPath: documentsPath)) {
            return documentsPath
        } else {
            return Bundle.main.path(forResource: file, ofType: fileExtension)
        }
        
    }//get path in documents directory, or main bundle
    
    open class func createDirectoryAtPath(_ path:String) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectoryPath = paths[0] as NSString
        
        var filePath = documentDirectoryPath
        filePath = filePath.appendingPathComponent(path) as NSString
        
        if (!FileManager.default.fileExists(atPath: filePath as String)) {
            do {
                try FileManager.default.createDirectory(atPath: filePath as String, withIntermediateDirectories: false, attributes: nil)
            } catch _ {
            }
        }//folder needs to be created
        
    }//create directory at path
    
    open class func contentsOfDirectory(_ directory:String, removeExtensions:Bool = true) -> [URL] {

        do {
            var url = try FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            url = url.appendingPathComponent(directory)
            
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            
            if removeExtensions {
                return contents.flatMap() { $0.deletingPathExtension() }
            }
            
            return contents
            /*
            let contents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(totalDirectory)

            if removeExtensions {
                return contents.flatMap() { NSURL(string: $0)?.URLByDeletingPathExtension }
            } else {
                return contents.flatMap() { NSURL(string: $0) }
            }
            */
        } catch {
            return []
        }
        
    }
    
}
