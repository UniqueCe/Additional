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
    
    /**
     获取颜色，通过16进制色值字符串，e.g. #ff0000， ff0000
     - parameter hexString  : 16进制字符串
     - parameter alpha      : 透明度，默认为1，不透明
     - returns: RGB
     */
    class func colorwithHexString(hexString hex: String, alpha:CGFloat = 1) -> UIColor {
        // 去除空格等
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 去除#
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        // 必须为6位
        if (cString.count != 6) {
            return UIColor.gray
        }
        // 红色的色值
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        // 字符串转换
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    
    /// color的UIimage
    ///
    /// - Parameter color: color
    /// - Returns: UIimage
    class func createImageWithColor(color:UIColor) -> UIImage {
        
        let rect=CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return theImage!;
    }
}
