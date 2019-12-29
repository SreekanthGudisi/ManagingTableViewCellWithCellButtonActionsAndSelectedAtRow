//
//  Helpers.swift
//  WonUpItAssignment
//
//  Created by Gudisi, Sreekanth on 17/12/19.
//  Copyright © 2019 Gudisi, Sreekanth. All rights reserved.
//

import Foundation
import UIKit

// MARK :- https://stackoverflow.com/questions/22422480/apply-black-and-white-filter-to-uiimage
extension UIImage {
    
    // Create a grayscale image with alpha channel. Is 5 times faster than grayscaleImage().
    // - Returns: The grayscale image of self if available.
    var grayScaled: UIImage? {
        // Create image rectangle with current image width/height * scale
        let pixelSize = CGSize(width: self.size.width * self.scale, height: self.size.height * self.scale)
        let imageRect = CGRect(origin: CGPoint.zero, size: pixelSize)
        // Grayscale color space
         let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()

            // Create bitmap content with current image size and grayscale colorspace
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        if let context: CGContext = CGContext(data: nil, width: Int(pixelSize.width), height: Int(pixelSize.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
            {
                // Draw image into current context, with specified rectangle
                // using previously defined context (with grayscale colorspace)
                guard let cg = self.cgImage else{
                    return nil
                }
                context.draw(cg, in: imageRect)
                // Create bitmap image info from pixel data in current context
                if let imageRef: CGImage = context.makeImage(){
                    let bitmapInfoAlphaOnly = CGBitmapInfo(rawValue: CGImageAlphaInfo.alphaOnly.rawValue)

                    guard let context = CGContext(data: nil, width: Int(pixelSize.width), height: Int(pixelSize.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfoAlphaOnly.rawValue) else{
                        return nil
                    }
                    context.draw(cg, in: imageRect)
                    if let mask: CGImage = context.makeImage() {
                        // Create a new UIImage object
                        if let newCGImage = imageRef.masking(mask){
                            // Return the new grayscale image
                            return UIImage(cgImage: newCGImage, scale: self.scale, orientation: self.imageOrientation)
                        }
                    }

                }
            }
        // A required variable was unexpected nil
        return nil
    }
}
