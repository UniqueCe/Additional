//
//  toolbarView.swift
//  swifUIPickerViewDemo
//
//  Created by lzhl_iOS on 2018/1/5.
//  Copyright © 2018年 lzhl_iOS. All rights reserved.
//

import UIKit

let toolBarHeight = 45
private let ScreenHeight = UIScreen.main.bounds.height
private let ScreenWidth = UIScreen.main.bounds.width

class toolbarView: UIView {
    
    fileprivate lazy var leftButton: UIButton = {
       
        let leftBtn = UIButton(frame: CGRect(x: 10, y: 5, width: 64, height: 35))
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        leftBtn.backgroundColor = UIColor.red
        leftBtn.layer.masksToBounds = true
        leftBtn.layer.cornerRadius = 5.0
        return leftBtn
    }()
    
    fileprivate lazy var rightButton: UIButton = {
        
        let rightBtn = UIButton(frame: CGRect(x: ScreenWidth-64-10, y: 5, width: 64, height: 35))
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightBtn.backgroundColor = UIColor.red
        rightBtn.layer.masksToBounds = true
        rightBtn.layer.cornerRadius = 5.0
        return rightBtn
    }()
    
    lazy var titleLabel: UILabel = {
        
        let titleLa = UILabel()
        let titleX = 84
        titleLa.frame = CGRect(x: Int(titleX), y: 0, width: Int(ScreenWidth - 2 * CGFloat(titleX)), height: toolBarHeight)
        titleLa.textAlignment = .center
        titleLa.font = UIFont.systemFont(ofSize: 15)
        titleLa.adjustsFontSizeToFitWidth = true
        return titleLa
    }()
    
    /** btn.backgroundColor */
    var BtnColor: UIColor? {
        didSet {
            
            if BtnColor != nil {
                rightButton.backgroundColor = BtnColor
                leftButton.backgroundColor = BtnColor
            }
        }
    }
    
    /** leftBtn.backgroundColor */
    var leftBtnColor: UIColor? {
        didSet {
            if leftBtnColor != nil {
                leftButton.backgroundColor = leftBtnColor
            }
        }
    }
    
    /** rightBtn.backgroundColor */
    var rightBtnColor: UIColor? {
        didSet {
            if rightBtnColor != nil {
                rightButton.backgroundColor = rightBtnColor
            }
        }
    }
    
    convenience init(title: String?, cancelBtnTitle: String?, okBtnTitle: String?, target: Any?,cancelAction: Selector, okBtnAction: Selector) {
        
        self.init()
        
        titleLabel.text = title
        leftButton.setTitle(cancelBtnTitle, for: .normal)
        leftButton.addTarget(target, action: cancelAction, for: .touchUpInside)
        rightButton.setTitle(okBtnTitle, for: .normal)
        rightButton.addTarget(target, action: okBtnAction, for: .touchUpInside)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.white
        bounds = CGRect(x: 0, y: 0, width: Int(ScreenWidth), height: toolBarHeight)
        
        setUpToolBarViewUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension toolbarView {
    
    func setUpToolBarViewUI() {
        
        addSubview(leftButton)
        addSubview(titleLabel)
        addSubview(rightButton)
    }
}
