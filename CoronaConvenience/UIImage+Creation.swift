//
//  UIImage+Creation.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 12/10/14.
//  Copyright (c) 2014 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit

public extension UIImage {
    /*
    public class func imageWithPDFFile(file:String, size:CGSize, useOptions:Bool = false) -> UIImage? {
        
        if let bundleStr = NSBundle.mainBundle().pathForResource(file, ofType: ".pdf") {
            
            if let bundleURL = NSURL.fileURLWithPath(bundleStr) {
                
                let pdfDoc = CGPDFDocumentCreateWithURL(bundleURL)
                let pdfPage = CGPDFDocumentGetPage(pdfDoc, 1)
                let pageFrame = CGPDFPageGetBoxRect(pdfPage, kCGPDFCropBox)
                
                if useOptions {
                    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
                } else {
                    UIGraphicsBeginImageContext(size)
                }
                let context = UIGraphicsGetCurrentContext()
                CGContextSaveGState(context)
                
                CGContextTranslateCTM(context, 0, size.height)
                CGContextScaleCTM(context, size.width / pageFrame.size.width, -size.height / pageFrame.size.height)
                CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(pdfPage, kCGPDFCropBox, pageFrame, 0, true))
                
                CGContextDrawPDFPage(context, pdfPage)
                
                let image = UIGraphicsGetImageFromCurrentImageContext()
                let data = UIImagePNGRepresentation(image)
                
                CGContextRestoreGState(context)
                UIGraphicsEndImageContext()
                
                return UIImage(data: data)!
            }//valid url
            
        }//valid file path
        
        return nil
    }//create image with pdf file
    */
    public class func imageWithPDFFile(file:String, size:CGSize) -> UIImage? {
        
        if let bundleStr = NSBundle.mainBundle().pathForResource(file, ofType: ".pdf") {
            let bundleURL = NSURL.fileURLWithPath(bundleStr)
                
            let pdfDoc = CGPDFDocumentCreateWithURL(bundleURL)
            let pdfPage = CGPDFDocumentGetPage(pdfDoc, 1)
            let pageFrame = CGPDFPageGetBoxRect(pdfPage, CGPDFBox.CropBox)
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            
            let retina              = UIView.getRetinaScale()
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
                return UIImage(CGImage: image, scale: retina, orientation: .Up)
            }
        }//valid file path
        
        return nil
    }
    
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
    
}//UIImage
#endif