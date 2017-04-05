//
//  UIButton_Extension.swift
//  Alert_Swift
//
//  Created by lzhl_iOS on 2017/3/29.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit

extension  UIButton {
  
    private class func buttonWithTitle(title: String? ,selecteTitle: String? ,image: String? ,selecteImage: String? ,titleColor: UIColor? ,titleSelecteColor: UIColor? ,backgroundImage: String? ,backgroundSelecteImage: String?) -> UIButton {

        let btn = UIButton()
        
        btn.setTitle(title, for: .normal)
        btn.setTitle(selecteTitle, for: .selected)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setTitleColor(titleSelecteColor, for: .selected)
        
        if image != nil {
            
            btn.setImage(UIImage(named:image!), for: .normal)
        }
        
        if selecteImage != nil {

            btn.setImage(UIImage(named:selecteImage!) , for: .selected)
        }
        
        if backgroundImage != nil {
           
           btn.setBackgroundImage(UIImage(named:backgroundImage!), for: .normal)
        }
        
        if backgroundSelecteImage != nil {
            
            btn.setBackgroundImage(UIImage(named:backgroundSelecteImage!), for: .selected)
        }
        
        return btn
    }
    
    //MARK:文字Btn
    class func buttonWithTitleBtn(title: String? ,selecteTitle: String? ,titleColor: UIColor? ,titleSelecteColor: UIColor? ) -> UIButton {
        
        return buttonWithTitle(title: title, selecteTitle: selecteTitle, image: nil, selecteImage: nil, titleColor: titleColor, titleSelecteColor: titleSelecteColor, backgroundImage: nil, backgroundSelecteImage: nil)
    }
    
    
    //MARK:背景图片+文字
    class func buttonWithTitleAndBackgroundImageBtn(title: String? ,selecteTitle: String? ,titleColor: UIColor? ,titleSelecteColor: UIColor? ,backgroundImage: String? ,backgroundSelecteImage: String?) -> UIButton {

       return buttonWithTitle(title: title, selecteTitle: selecteTitle, image: nil, selecteImage: nil, titleColor: titleColor, titleSelecteColor: titleSelecteColor, backgroundImage: backgroundImage, backgroundSelecteImage: backgroundSelecteImage)
    }

    //MARK:图片Btn
    class func buttonWithImageBtn(image: String? ,selecteImage: String?) -> UIButton {
        
        return buttonWithTitle(title: nil, selecteTitle: nil, image: image, selecteImage: selecteImage, titleColor: nil, titleSelecteColor: nil, backgroundImage: nil, backgroundSelecteImage: nil)
    }
    
    //MARK:背景色+文字
    class func buttonWithTitleAndBackgroundColorBtn(title: String? ,selecteTitle: String? ,titleColor: UIColor? ,titleSelecteColor: UIColor? ,backgroundColor: UIColor) -> UIButton {

        let btn = UIButton.buttonWithTitleBtn(title: title, selecteTitle: selecteTitle, titleColor: titleColor, titleSelecteColor: titleSelecteColor)
        btn.backgroundColor = backgroundColor
        
        return btn
    }
    
    //MARK:btn图文混排
    class func buttonWithImage_Text(title: String? ,selecteTitle: String? ,image: String? ,selecteImage: String? ,titleColor: UIColor? ,titleSelecteColor: UIColor? ,titleEdgeInsets: UIEdgeInsets ,imageEdgeInsets: UIEdgeInsets) -> UIButton {

        let btn = UIButton.buttonWithTitle(title: title, selecteTitle: selecteTitle, image: image, selecteImage: selecteImage, titleColor: titleColor, titleSelecteColor: titleSelecteColor, backgroundImage: nil, backgroundSelecteImage: nil)
        
        btn.titleEdgeInsets = titleEdgeInsets
        btn.imageEdgeInsets = imageEdgeInsets
        
        return btn
    }
    
}



