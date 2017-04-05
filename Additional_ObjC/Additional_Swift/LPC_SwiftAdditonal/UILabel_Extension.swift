//
//  UILabel_Extension.swift
//  Alert_Swift
//
//  Created by lzhl_iOS on 2017/3/29.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit


extension UILabel {

    convenience init(text:String ,fontSize:CGFloat ,textColor:UIColor) {
        
        self.init()
        
        self.text = text
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.numberOfLines = 0
        
    }
    
    
}

