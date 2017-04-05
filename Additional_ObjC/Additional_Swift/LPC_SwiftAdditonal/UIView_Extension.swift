//
//  UIView_Extension.swift
//  Alert_Swift
//
//  Created by lzhl_iOS on 2017/3/27.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK:Frame Origin
    var Origin_x: CGFloat {
        
        get {
            return frame.origin.x
        } set {
            frame.origin.x = newValue
        }
    }
    
    var Origin_y: CGFloat {
        
        get {
            return frame.origin.y
        } set {
            frame.origin.y = newValue
        }
    }
    
    //MARK:Frame Size
    var Size_width: CGFloat {
        
        get {
            return frame.size.width
        } set {
            frame.size.width = newValue
        }
    }
    
    var Size_height: CGFloat {
        
        get {
            return frame.size.height
        } set {
            frame.size.height = newValue
        }
    }
    
    //MARK:Center
    var CenterX : CGFloat {
        
        get {
            return center.x
        } set {
            center.x = newValue
        }
    }
    
    var CenterY : CGFloat {
        
        get {
            return center.y
        } set {
            center.y = newValue
        }
    }
    
    //MARK:Frame
    var Size : CGSize {
        
        get {
            return frame.size
        } set {
            frame.size = newValue
        }
    }
    
    var Origin : CGPoint {
        
        get {
            return frame.origin
        } set {
            frame.origin = newValue
        }
    }
    
    //MAKR:返回屏幕截图 -->还是写在项目中用吧！！！
    /* func snapShotImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        return result
    } */
    
}
