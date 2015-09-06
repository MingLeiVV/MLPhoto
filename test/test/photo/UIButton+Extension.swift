//
//  UIButton+Extension.swift
//  MLPhoto
//
//  Created by 吴明磊 on 15/8/8.
//  Copyright © 2015年 wuminglei. All rights reserved.
//

import UIKit


extension UIButton {



    /// - parameter target: 执行对象
    /// - parameter action: 方法名
    /// - parameter image : 图片名
    convenience init(target : AnyObject, action : String ,image : String) {
         self.init()
        
        addTarget(target, action: Selector(action), forControlEvents: UIControlEvents.TouchUpInside)
        setImage(UIImage(named: image), forState: UIControlState.Normal)
        setImage(UIImage(named: image + "_highlighted"), forState: UIControlState.Highlighted)
    }

}