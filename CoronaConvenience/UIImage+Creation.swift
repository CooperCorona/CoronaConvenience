//
//  UIImage+Creation.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 12/10/14.
//  Copyright (c) 2014 Cooper Knaak. All rights reserved.
//

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

    public class func imageWithPDFFile(file:String, size:CGSize) -> ImageType? {
        
        if let bundleStr = NSBundle.mainBundle().pathForResource(file, ofType: ".pdf") {
            let bundleURL = NSURL.fileURLWithPath(bundleStr)
                
            let pdfDoc = CGPDFDocumentCreateWithURL(bundleURL)
            let pdfPage = CGPDFDocumentGetPage(pdfDoc, 1)
            let pageFrame = CGPDFPageGetBoxRect(pdfPage, CGPDFBox.CropBox)
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            let retina              = getRetinaScale()
            let width               = Int(size.width * retina)
            let height              = Int(size.height * retina)
            let bytesPerPixel       = 4
            let bitsPerComponent    = 8
            let bytesPerRow         = bytesPerPixel * width
            let bitmapInfo          = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
            
            let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)
            
            CGContextSaveGState(context)
            
            CGContextScaleCTM(context, retina * size.width / pageFrame.size.width, retina * size.height / pageFrame.size.height)
            CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(pdfPage, CGPDFBox.CropBox, pageFrame, 0, true))
            
            CGContextDrawPDFPage(context, pdfPage)
            
            let image = CGBitmapContextCreateImage(context)
            
            CGContextRestoreGState(context)
            
            if let image = image {
                #if os(iOS)
                return UIImage(CGImage: image, scale: retina, orientation: .Up)
                #else
                return NSImage(CGImage: image, size: size)
                #endif
            }
        }//valid file path
        
        return nil
    }
    
    public class func imageWithPDFURL(pdfURL:NSURL, size:CGSize) -> ImageType? {
        let pdfDoc = CGPDFDocumentCreateWithURL(pdfURL)
        let pdfPage = CGPDFDocumentGetPage(pdfDoc, 1)
        let pageFrame = CGPDFPageGetBoxRect(pdfPage, CGPDFBox.CropBox)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let retina              = getRetinaScale()
        let width               = Int(size.width * retina)
        let height              = Int(size.height * retina)
        let bytesPerPixel       = 4
        let bitsPerComponent    = 8
        let bytesPerRow         = bytesPerPixel * width
        let bitmapInfo          = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        
        let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, bytesPerRow, colorSpace, bitmapInfo.rawValue)
        
        CGContextSaveGState(context)
        
        CGContextScaleCTM(context, retina * size.width / pageFrame.size.width, retina * size.height / pageFrame.size.height)
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(pdfPage, CGPDFBox.CropBox, pageFrame, 0, true))
        
        CGContextDrawPDFPage(context, pdfPage)
        
        let image = CGBitmapContextCreateImage(context)
        
        CGContextRestoreGState(context)
        
        guard let cgImage = image else {
            return nil
        }
        
        #if os(iOS)
        return UIImage(CGImage: cgImage, scale: retina, orientation: .Up)
        #else
        return NSImage(CGImage: cgImage, size: size)
        #endif
    }

    #if os(iOS)
    public func addColor(color:UIColor) -> UIImage {
        
        let frame = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        
        self.drawAtPoint(CGPointZero)
        
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1, -1)
        
        CGContextClipToMask(context, frame, self.CGImage)
        
        CGContextSetBlendMode(context, CGBlendMode.Multiply)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, frame)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        CGContextRestoreGState(context)
        UIGraphicsEndImageContext()
        
        return image
    }//add color to this image
    
    public func addText(text:NSAttributedString) -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        
        self.drawAtPoint(CGPointZero)
        
        let tSize = text.size()
        text.drawAtPoint(CGPoint(x: (self.size.width - tSize.width) / 2.0, y: (self.size.height - tSize.height) / 2.0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        CGContextRestoreGState(context)
        UIGraphicsEndImageContext()
        
        return image
    }//add text to this image
    #endif
    
}//UIImage
