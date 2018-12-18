//
//  pickerAreaerBtnView.swift
//  swifUIPickerViewDemo
//
//  Created by lzhl_iOS on 2018/1/5.
//  Copyright © 2018年 lzhl_iOS. All rights reserved.
//

import UIKit
import SwiftyJSON

private let ScreenHeight = UIScreen.main.bounds.height
private let ScreenWidth = UIScreen.main.bounds.width
private let PickerViewHeight: CGFloat = 300

/** 代理方法 */
@objc protocol pickerAreaerBtnViewDelegate: NSObjectProtocol {
    
    /** 返回 省市区 */
    func pickerAreaer(_ pickerAreaer: pickerAreaerBtnView, province: String, city: String, area: String)
    
    /** 返回 省市区id */
    @objc optional func pickerAreaer(_ pickerAreaer: pickerAreaerBtnView, provinceID:Int, cityID: Int, areaID: Int)
}

class pickerAreaerBtnView: UIButton {
    
    fileprivate lazy var pickerView: UIPickerView = {
       
        let pick = UIPickerView(frame: CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: PickerViewHeight - CGFloat(toolBarHeight)))
        pick.delegate = self
        pick.dataSource = self
        pick.backgroundColor = UIColor.white
        return pick
    }()
    
    fileprivate lazy var lineView: UIView = {
        
        let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: ScreenWidth, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    fileprivate lazy var ToolBarView: toolbarView = {
        
        let toolBar = toolbarView(title: "请选择", cancelBtnTitle: "取消", okBtnTitle: "确认", target: self, cancelAction: #selector(cancelBtnClickAction), okBtnAction: #selector(okBtnClickAction))
        toolBar.frame = CGRect(x: 0, y: Int(ScreenHeight), width: Int(ScreenWidth), height: toolBarHeight)
        toolBar.backgroundColor = UIColor.white
        return toolBar
    }()
    
    /** 代理 */
    weak var delegate: pickerAreaerBtnViewDelegate?
    
    fileprivate lazy var dictRoot = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "area_New_FuWuQi", ofType: "plist")!)

    /** 省 组 */
    fileprivate var arrayProvince = [FirstModel]()
    /** 城市 组 */
    fileprivate var arrayCity = [SecondModel]()
    /** 地区 组 */
    fileprivate var arrayArea = [ThirdModel]()
    /** 省份 */
    fileprivate var province: String?
    /** 城市 */
    fileprivate var city: String?
    /** 地区 */
    fileprivate var area: String?
    /** 省份id */
    fileprivate var province_id: Int?
    /** 城市id */
    fileprivate var city_id: Int?
    /** 地区id */
    fileprivate var area_id: Int?
    
    convenience init(delegate:pickerAreaerBtnViewDelegate?) {
        self.init()
        self.delegate = delegate
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupPickerAreaerBtnViewUI()
        loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension pickerAreaerBtnView {
    
    func loadData() {
    
        let temp  = JSON(dictRoot as Any)
  
        if let tempFirst = temp["first"].arrayObject {
            for tempModels in tempFirst {
                let tempM = FirstModel(dict: tempModels as! [String:AnyObject])
                arrayProvince.append(tempM)
            }
        }
        
        arrayCity = arrayProvince[0].second
        arrayArea = arrayCity[0].third
        
        reloadDataTitle()
    }
    
    func reloadDataTitle() {
        
        province = arrayProvince[pickerView.selectedRow(inComponent: 0)].name
        province_id = arrayProvince[pickerView.selectedRow(inComponent: 0)].id
        city = arrayCity[pickerView.selectedRow(inComponent: 1)].name
        city_id = arrayCity[pickerView.selectedRow(inComponent: 1)].id
        area = arrayArea[pickerView.selectedRow(inComponent: 2)].name
        area_id = arrayArea[pickerView.selectedRow(inComponent: 2)].id
        
        ToolBarView.titleLabel.text = "\((province)!) \((city)!) \((area)!)"
    }
}

extension pickerAreaerBtnView {
    
    func setupPickerAreaerBtnViewUI() {
        
        backgroundColor = UIColor.black.withAlphaComponent(0.4)
        bounds = UIScreen.main.bounds
        addTarget(self, action: #selector(removePickAreaerBtnView), for: .touchUpInside)
        
        addSubview(pickerView)
        pickerView.addSubview(lineView)
        addSubview(ToolBarView)
    }
    
    func showPickAreaerBtnView() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        center = (UIApplication.shared.keyWindow?.center)!
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
        
        UIView.animate(withDuration: 0.33, animations: {
            self.layer.opacity = 1.0
            self.ToolBarView.frame = CGRect(x: 0, y: Int(ScreenHeight - PickerViewHeight), width: Int(ScreenWidth), height: toolBarHeight)
            self.pickerView.frame = CGRect(x: 0, y: Int(ScreenHeight - PickerViewHeight + CGFloat(toolBarHeight)), width: Int(ScreenWidth), height: Int(PickerViewHeight - CGFloat(toolBarHeight)))
        }) { (finished) in }
        
    }
    
    @objc fileprivate func removePickAreaerBtnView() {
        
        UIView.animate(withDuration: 0.33, animations: {
            self.layer.opacity = 0
            self.ToolBarView.frame = CGRect(x: 0, y: Int(ScreenHeight), width: Int(ScreenWidth), height: toolBarHeight)
            self.pickerView.frame = CGRect(x: 0, y: Int(ScreenHeight), width: Int(ScreenWidth), height: Int(PickerViewHeight - CGFloat(toolBarHeight)))
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    @objc fileprivate func cancelBtnClickAction() {
        
        removePickAreaerBtnView()
    }
    
    @objc fileprivate func okBtnClickAction() {

        if delegate != nil {
            delegate?.pickerAreaer(self, province: province!, city: city!, area: area!)
            delegate?.pickerAreaer!(self, provinceID: province_id!, cityID: city_id!, areaID: area_id!)
        }
        
        removePickAreaerBtnView()
    }
}

extension pickerAreaerBtnView: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if component == 0 {
            return arrayProvince.count
        }else if component == 1 {
            return arrayCity.count
        }else {
            return arrayArea.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            
            arrayCity = arrayProvince[row].second
            arrayArea = arrayCity[0].third
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else if component == 1 {
            
            arrayArea = arrayCity[row].third
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }
        
        reloadDataTitle()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let templabel = UILabel()
        templabel.textAlignment = .center
        templabel.font = UIFont.systemFont(ofSize: 15)
        
        if component == 0 {
            templabel.text = arrayProvince[row].name
        }else if component == 1 {
            templabel.text = arrayCity[row].name
        }else {
            templabel.text = arrayArea[row].name
        }
        return templabel
    }
}
