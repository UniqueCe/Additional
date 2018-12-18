//
//  textAndImageButton.swift
//  GoldUnionSwift
//
//  Created by lzhl_iOS on 2018/1/16.
//  Copyright © 2018年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit

/// 左文字 右图片
class textAndImageButton: UIButton {

    func textAndImage(title: String, imageName: String)  {
        
        setTitle(title, for: .normal)
        setImage(UIImage(named: imageName), for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (imageView?.Origin_x)! < (titleLabel?.Origin_x)! {
            
            titleLabel?.Origin_x = (imageView?.Origin_x)! - 12
            imageView?.Origin_x = (titleLabel?.maxX)! + 10
        }
    }
}
