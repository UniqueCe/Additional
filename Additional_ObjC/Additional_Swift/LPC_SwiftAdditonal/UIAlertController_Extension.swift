//
//  UIAlertController_Extension.swift
//  Alert_Swift
//
//  Created by lzhl_iOS on 2017/3/27.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    private class func alertController(title:String? ,message:String? ,style:UIAlertControllerStyle , actionTitle:String?,actionStyle:UIAlertActionStyle , handlerClosures: ((UIAlertAction)->())?) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if (actionTitle != nil && actionTitle != "" ) {
        
            let action = UIAlertAction(title: actionTitle, style: actionStyle, handler: handlerClosures)
            
            alert.addAction(action)
        }
        return alert
    }
    
    /*
        alertController 和 actionSheetController 默认的actionStyle格式是default格式
     */
    
    //MARK:创建AlertController
    class func alertController(title:String? ,message:String? , actionTitle:String? , handlerClosures: ((UIAlertAction)->())?) -> UIAlertController  {
    
        return alertController(title: title, message: message, style: .alert, actionTitle: actionTitle, actionStyle: .default, handlerClosures: handlerClosures)
    }
    
    //MARK:创建AlertSheetController
    class func actionSheetController(title:String? ,message:String? , actionTitle:String? , handlerClosures: ((UIAlertAction)->())?) -> UIAlertController  {
        
        return alertController(title: title, message: message, style: .actionSheet, actionTitle: actionTitle, actionStyle: .default, handlerClosures: handlerClosures)
    }
    
   
    
}
