//
//  FirstModel.swift
//  swifUIPickerViewDemo
//
//  Created by 刘培策 on 2018/1/7.
//  Copyright © 2018年 lzhl_iOS. All rights reserved.
//

import UIKit

class FirstModel: NSObject {
    
    /*
     "id": 1,
     "name": "\u5317\u4eac\u5e02",
     "pid": 0,
     "level": 1,
     "second":[]
     */
    var id: Int?
    
    var name: String?
    
    var pid: Int?
    
    var level: Int?
    
    var second = [SecondModel]()
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        pid = dict["pid"] as? Int
        level = dict["level"] as? Int
        
        if let goods_cartModelsTemp = dict["second"] as? [AnyObject] {
            for item in goods_cartModelsTemp {
                let module = SecondModel(dict: item as! [String : AnyObject])
                second.append(module)
            }
        }
    }
}

class SecondModel: NSObject {
    
    /*
     "id": 1,
     "name": "\u5317\u4eac\u5e02",
     "pid": 0,
     "level": 1,
     "second":[]
     */
    var id: Int?
    
    var name: String?
    
    var pid: Int?
    
    var level: Int?
    
    var third = [ThirdModel]()
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        pid = dict["pid"] as? Int
        level = dict["level"] as? Int
        
        if let goods_cartModelsTemp = dict["third"] as? [AnyObject] {
            for item in goods_cartModelsTemp {
                let module = ThirdModel(dict: item as! [String : AnyObject])
                third.append(module)
            }
        }
    }
}

class ThirdModel: NSObject {
    
    /*
     {
     "id": 377,
     "name": "\u4e1c\u57ce\u533a",
     "pid": 32,
     "level": 3
     }
     */
    var id: Int?
    
    var name: String?
    
    var pid: Int?
    
    var level: Int?
    
    init(dict: [String: AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        pid = dict["pid"] as? Int
        level = dict["level"] as? Int
    }
}

