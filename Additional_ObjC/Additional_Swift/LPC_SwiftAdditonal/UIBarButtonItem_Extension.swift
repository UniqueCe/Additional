//
//  UIBarButtonItem_Extension.swift
//  Alert_Swift
//
//  Created by lzhl_iOS on 2017/4/1.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func setBarButton(title: String? ,titleColor: UIColor? ,image:String? ,target: Any? ,action: Selector) -> UIBarButtonItem {
        
        let barBtn = UIBarButtonItem()
        
        let itemBtn = UIButton.buttonWithTitleBtn(title: title, selecteTitle: nil, titleColor: titleColor, titleSelecteColor: nil)

        if image != nil {
            
            itemBtn.setImage(UIImage(named: image!), for: .normal)
        }
        
        itemBtn.sizeToFit()
        itemBtn.addTarget(target, action: action, for: .touchUpInside)

        barBtn.customView = itemBtn
        
        return barBtn
    }

}
