//
//  UIImage+Compress.swift
//  MLPhoto
//
//  Created by 吴明磊 on 15/8/8.
//  Copyright © 2015年 wuminglei. All rights reserved.
//

import UIKit

extension UIImage {

    func compressImage (width : CGFloat) -> UIImage {
    
        if size.width < width {
        
            return self
        }
        
        let scale = size.height / size.width
        
        let H = scale * width
        
        let sizeRef = CGSize(width: width, height: H)
        UIGraphicsBeginImageContext(sizeRef)
        
        drawInRect(CGRect(origin: CGPointZero, size: sizeRef))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        
        return img
    }
}