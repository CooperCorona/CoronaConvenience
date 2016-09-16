//
//  UIImage+Creation.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 12/10/14.
//  Copyright (c) 2014 Cooper Knaak. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#else
import Cocoa
#endif

#if os(iOS)
public typealias ImageType = UIImage
#else
public typealias ImageType = NSImage
#endif

public extension ImageType {

    public class func imageWithPDFFile(_ file:String, size:CGSize) -> ImageType? {
        
        if let bundleStr = Bundle.main.path(forResource: file, ofType: ".pdf") {
            let bundleURL = NSURL(fileURLWithPath: bundleStr)
            
            let pdfDoc = CGPDFDocument(bundleURL)!
            let pdfPage = pdfDoc.page(at: 1)!
            let pageFrame = pdfPage.getBoxRect(CGPDFBox.cropBox)
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            let retina              = getRetinaScale()
            let width               = Int(size.width * retina)
            let height              = Int(size.height * retina)
            let bytesPerPixel       = 4
            let bitsPerComponent    = 8
            let bytesPerRow         = bytesPerPixel * width
            let bitmapInfo          = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
            
            let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
            
            context?.saveGState()
            
            context?.scaleBy(x: retina * size.width / pageFrame.size.width, y: retina * size.height / pageFrame.size.height)
            context?.concatenate(pdfPage.getDrawingTransform(CGPDFBox.cropBox, rect: pageFrame, rotate: 0, preserveAspectRatio: true))
            
            context?.drawPDFPage(pdfPage)
            
            let image = context?.makeImage()
            
            context?.restoreGState()
            
            if let image = image {
                #if os(iOS)
                return UIImage(cgImage: image, scale: retina, orientation: .up)
                #else
                return NSImage(cgImage: image, size: size)
                #endif
            }
        }//valid file path
        
        return nil
    }
    
    public class func imageWithPDFURL(_ pdfURL:NSURL, size:CGSize) -> ImageType? {
        let pdfDoc = CGPDFDocument(pdfURL)!
        let pdfPage = pdfDoc.page(at: 1)!
        let pageFrame = pdfPage.getBoxRect(CGPDFBox.cropBox)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let retina              = getRetinaScale()
        let width               = Int(size.width * retina)
        let height              = Int(size.height * retina)
        let bytesPerPixel       = 4
        let bitsPerComponent    = 8
        let bytesPerRow         = bytesPerPixel * width
        let bitmapInfo          = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context?.saveGState()
        
        context?.scaleBy(x: retina * size.width / pageFrame.size.width, y: retina * size.height / pageFrame.size.height)
        context?.concatenate(pdfPage.getDrawingTransform(CGPDFBox.cropBox, rect: pageFrame, rotate: 0, preserveAspectRatio: true))
        
        context?.drawPDFPage(pdfPage)
        
        let image = context?.makeImage()
        
        context?.restoreGState()
        
        guard let cgImage = image else {
            return nil
        }
        
        #if os(iOS)
        return UIImage(cgImage: cgImage, scale: retina, orientation: .up)
        #else
        return NSImage(cgImage: cgImage, size: size)
        #endif
    }

    #if os(iOS)
    public func addColor(color:UIColor) -> UIImage {
        
        let frame = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        
        self.draw(at: CGPoint.zero)
        
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1, y: -1)
        
        context!.clip(to: frame, mask: self.cgImage!)
        
        context!.setBlendMode(CGBlendMode.multiply)
        context!.setFillColor(color.cgColor)
        context!.fill(frame)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        context!.restoreGState()
        UIGraphicsEndImageContext()
        
        return image!
    }//add color to this image
    
    public func addText(text:NSAttributedString) -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        
        self.draw(at: CGPoint.zero)
        
        let tSize = text.size()
        text.draw(at: CGPoint(x: (self.size.width - tSize.width) / 2.0, y: (self.size.height - tSize.height) / 2.0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        context!.restoreGState()
        UIGraphicsEndImageContext()
        
        return image!
    }//add text to this image
    #endif
    
}//UIImage
