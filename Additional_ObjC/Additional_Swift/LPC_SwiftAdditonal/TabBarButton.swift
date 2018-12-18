//
//  TabBarButton.swift
//  充电桩
//
//  Created by mac on 2018/5/22.
//  Copyright © 2018年 lianzhonghulian. All rights reserved.
//

import UIKit

/// 上文字 下图片btn
class TabBarButton: UIButton {
    /*
    private lazy var numLabel: UILabel = {
        let temp = UILabel(text: "99", fontSize: 10, textColor: UIColor.white)
        temp.layer.masksToBounds = true
        temp.textAlignment = .center
        temp.layer.cornerRadius = 10
        temp.backgroundColor = UIColor.red
        temp.isHidden = true
        return temp
    }()
    
    var num: Int = 0 {
        didSet {
            if num > 0 {
                numLabel.isHidden = false
                numLabel.text = "\(num)"
            }else {
                numLabel.isHidden = true
            }
        }
    }*/
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 图标居中
        imageView?.contentMode = .center;
        // 文字居中
        titleLabel?.textAlignment = .center;
        
//        addSubview(numLabel)
//        numLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(self.snp.top).offset(5)
//            make.right.equalTo(self.snp.right).offset(-5)
//            make.size.equalTo(CGSize(width: 20, height: 20))
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageW:CGFloat = contentRect.size.width;
        let imageH:CGFloat = contentRect.size.height*0.6
        return CGRect.init(x: 0, y: 0, width: imageW, height: imageH);
    }
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleY: CGFloat = contentRect.size.height * 0.6
        let titleW: CGFloat = contentRect.size.width
        let titleH: CGFloat = contentRect.size.height - titleY
        return CGRect(x: 0, y: titleY, width: titleW, height: titleH)
    }
}

