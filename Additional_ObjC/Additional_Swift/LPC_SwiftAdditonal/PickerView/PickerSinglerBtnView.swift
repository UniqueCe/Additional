//
//  PickerSinglerBtnView.swift
//  swifUIPickerViewDemo
//
//  Created by lzhl_iOS on 2018/1/8.
//  Copyright © 2018年 lzhl_iOS. All rights reserved.
//

import UIKit
import SwiftyJSON

private let ScreenHeight = UIScreen.main.bounds.height
private let ScreenWidth = UIScreen.main.bounds.width
private let PickerViewHeight: CGFloat = 300

/** 代理方法 */
protocol PickerSinglerBtnViewDelegate: NSObjectProtocol {
    
    /** 返回 选中的title 和 row */
    func pickerAreaer(_ pickerAreaer: PickerSinglerBtnView, selectorTitle: String ,selectorRow: Int)
}

class PickerSinglerBtnView: UIButton {
    
    private lazy var pickerView: UIPickerView = {
        
        let pick = UIPickerView(frame: CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: PickerViewHeight - CGFloat(toolBarHeight)))
        pick.delegate = self
        pick.dataSource = self
        pick.backgroundColor = UIColor.white
        return pick
    }()
    
    private lazy var lineView: UIView = {
        
        let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: ScreenWidth, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    private lazy var ToolBarView: toolbarView = {
        
        let toolBar = toolbarView(title: "请选择", cancelBtnTitle: "取消", okBtnTitle: "确认", target: self, cancelAction: #selector(cancelBtnClickAction), okBtnAction: #selector(okBtnClickAction))
        toolBar.frame = CGRect(x: 0, y: Int(ScreenHeight), width: Int(ScreenWidth), height: toolBarHeight)
        toolBar.backgroundColor = UIColor.white
        toolBar.leftBtnColor = UIColor.blue
        
        return toolBar
    }()
    
    /** 代理 */
    weak var delegate: PickerSinglerBtnViewDelegate?
    
    /** 数据源 */
    var dataSource: [Any]?
    
    var selectorTitle: String?
    
    var selecrtorRow: Int?
    
    convenience init(delegate:PickerSinglerBtnViewDelegate? ,dataSoureArray:[Any]) {
        self.init()
        self.delegate = delegate
        dataSource = dataSoureArray
    
        selectorTitle = "\((dataSource?[0])!)"
        selecrtorRow = 0
        ToolBarView.titleLabel.text = selectorTitle
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupPickerSinglerBtnViewUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PickerSinglerBtnView {
    
    private func setupPickerSinglerBtnViewUI() {
        
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        bounds = UIScreen.main.bounds
        addTarget(self, action: #selector(removePickerSinglerBtnView), for: .touchUpInside)
        
        addSubview(pickerView)
        pickerView.addSubview(lineView)
        addSubview(ToolBarView)
    }
    
    func showPickerSinglerBtnView() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        center = (UIApplication.shared.keyWindow?.center)!
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
        
        UIView.animate(withDuration: 0.33, animations: {
            self.layer.opacity = 1.0
            self.ToolBarView.frame = CGRect(x: 0, y: Int(ScreenHeight - PickerViewHeight), width: Int(ScreenWidth), height: toolBarHeight)
            self.pickerView.frame = CGRect(x: 0, y: Int(ScreenHeight - PickerViewHeight + CGFloat(toolBarHeight)), width: Int(ScreenWidth), height: Int(PickerViewHeight - CGFloat(toolBarHeight)))
        }) { (finished) in }
        
    }
    
    @objc fileprivate func removePickerSinglerBtnView() {
        
        UIView.animate(withDuration: 0.33, animations: {
            self.layer.opacity = 0
            self.ToolBarView.frame = CGRect(x: 0, y: Int(ScreenHeight), width: Int(ScreenWidth), height: toolBarHeight)
            self.pickerView.frame = CGRect(x: 0, y: Int(ScreenHeight), width: Int(ScreenWidth), height: Int(PickerViewHeight - CGFloat(toolBarHeight)))
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc fileprivate func cancelBtnClickAction() {
        
        removePickerSinglerBtnView()
    }
    
    @objc fileprivate func okBtnClickAction() {
        
        if delegate != nil {
            delegate?.pickerAreaer(self, selectorTitle: selectorTitle!, selectorRow: selecrtorRow!)
        }
        
        removePickerSinglerBtnView()
    }
}

extension PickerSinglerBtnView: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (dataSource?.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectorTitle = "\((dataSource?[row])!)"
        selecrtorRow = row
        ToolBarView.titleLabel.text = "\((dataSource?[row])!)"
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let templabel = UILabel()
        templabel.textAlignment = .center
        templabel.font = UIFont.systemFont(ofSize: 15)
        templabel.text = "\(dataSource![row])"
        return templabel
    }
}

