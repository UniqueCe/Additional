//
//  UIScreen_Extension.swift
//  Alert_Swift
//
//  Created by lzhl_iOS on 2017/3/27.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit

extension UIScreen {

    //MARK:屏幕宽度
    func LPC_ScreenWidth() -> CGFloat {
        
        return UIScreen.main.bounds.size.width
    }
    
    //MARK:屏幕高度
    func LPC_ScreenHeight() -> CGFloat {
        
        return UIScreen.main.bounds.size.height
    }
    
    //MARK:分辨率
    func LPC_ScreenScale() -> CGFloat {
        
        return UIScreen.main.scale
    }
    

}
