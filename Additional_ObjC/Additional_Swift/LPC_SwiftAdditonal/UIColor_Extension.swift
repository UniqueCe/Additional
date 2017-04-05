//
//  UIColor_Extension.swift
//  Alert_Swift
//
//  Created by lzhl_iOS on 2017/3/29.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit


extension UIColor {
    
    //MARK:RGB-Color
    class func colorWithRGB(R: CGFloat ,G: CGFloat ,B: CGFloat , alpha: CGFloat) -> UIColor {
        
        return UIColor(red: CGFloat(R)/CGFloat(255.0), green: CGFloat(G)/CGFloat(255.0), blue: CGFloat(B)/CGFloat(255.0), alpha: alpha)
    }
    
    //MARK:随机色
    class func colorWithRandomColor() -> UIColor {
    
        return self.colorWithRGB(R: CGFloat(arc4random_uniform(256)), G: CGFloat(arc4random_uniform(256)), B: CGFloat(arc4random_uniform(256)), alpha: 1)
    }
    
    //MARK:16进制颜色
    class func colorWithHex(hex:UInt32) -> UIColor {
    
        return self.colorWithRGB(R: CGFloat((hex & 0xFF0000) >> 16), G: CGFloat((hex & 0x00FF00) >> 8), B: CGFloat((hex & 0x0000FF)), alpha: 1)
    }
}
