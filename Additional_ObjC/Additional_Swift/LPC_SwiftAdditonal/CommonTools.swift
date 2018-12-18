//
//  CommonTools.swift
//  Additional_Swift
//
//  Created by iOS-UI on 2018/12/18.
//  Copyright © 2018 UniqueCe. All rights reserved.
//

import UIKit


/// dictionary 转 Json
func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    
    if (!JSONSerialization.isValidJSONObject(dictionary)) {
        print("无法解析出JSONString")
        return ""
    }
    let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}

/// JSONString转换为字典
func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
    
    let jsonData:Data = jsonString.data(using: .utf8)!
    
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
}

/// 缓存文件的大小
func fileSizeOfCache()-> Int {
    // 取出cache文件夹目录 缓存文件都在这个目录下
    let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
    //缓存目录路径 取出文件夹下所有文件数组
    let fileArr = FileManager.default.subpaths(atPath: cachePath!)
    //快速枚举出所有文件名 计算文件大小
    var size = 0
    for file in fileArr! {
        // 把文件名拼接到路径中
        let path = (cachePath! as NSString).appending("/\(file)")
        // 取出文件属性
        let floder = try! FileManager.default.attributesOfItem(atPath: path)
        // 用元组取出文件大小属性
        for (abc, bcd) in floder {
            // 累加文件大小
            if abc == FileAttributeKey.size {
                
                size += (bcd as AnyObject).integerValue
            }
        }
    }
    let mm = size / 1024 / 1024
    return mm
}

/// 清除缓存
func clearCache() {
    // 取出cache文件夹目录 缓存文件都在这个目录下
    let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
    // 取出文件夹下所有文件数组
    let fileArr = FileManager.default.subpaths(atPath: cachePath!)
    // 遍历删除
    for file in fileArr! {
        let path = (cachePath! as NSString).appending("/\(file)")
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                
            }
        }
    }
}

/// 判断字符串
func checkNullString(str: String) -> Bool {
    
    if str.isEmpty {
        return false
    }else {
        return true
    }
}

/// 判断手机号
func checkPhoneNumber(phoneNumber:String) -> Bool {
    
    if phoneNumber.count == 0 || phoneNumber.count > 11{
        return false
    }
    //#^13[\d]{9}$|^14[0-9]\d{8}$|^15[0-9]\d{8}$|^16[0-9]\d{8}$|^17[0-9]\d{8}$|^18[0-9]\d{8}$|^19[0-9]\d{8}$#
    let mobile = "^(13[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9])\\d{8}$"
    let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    if regexMobile.evaluate(with: phoneNumber) == true {
        return true
    }else {
        return false
    }
}
//将多少秒传进去得到00:00:00这种格式
func returnTimeTofammater(times:TimeInterval) -> String {
    if times==0{
        return "00:00:00"
    }
    var Min = Int(times / 60)
    let second = Int(times.truncatingRemainder(dividingBy: 60));
    var Hour = 0
    if Min>=60 {
        Hour = Int(Min / 60)
        Min = Min - Hour*60
        return String(format: "%02d : %02d : %02d", Hour, Min, second)
    }else if Min == 0{
        return String(format: "%02ds",second)
    }else if Min == 1{
        return String(format: "%02ds",times)
    }
    return String(format: "00 : %02d : %02d", Min, second)
}

/// 正则匹配用户身份证号15或18位
func checkUserIdCard(idCard:NSString) -> Bool {
    let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
    let isMatch:Bool = pred.evaluate(with: idCard)
    return isMatch;
}

/// 正则匹配用户密码6-18位数字和字母组合
func checkPassword(password:NSString) -> Bool {
    let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
    let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
    let isMatch:Bool = pred.evaluate(with: password)
    return isMatch;
}

/// 正则匹配URL
func checkURL(url:NSString) -> Bool {
    let pattern = "^[0-9A-Za-z]{1,50}"
    let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
    let isMatch:Bool = pred.evaluate(with: url)
    return isMatch;
}

/// 正则匹配用户姓名,20位的中文或英文
func checkUserName(userName:NSString) -> Bool {
    let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}"
    let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
    let isMatch:Bool = pred.evaluate(with: userName)
    return isMatch;
}

/// 正则匹配用户email
func checkEmail(email:NSString) -> Bool {
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
    let isMatch:Bool = pred.evaluate(with: email)
    return isMatch;
}


/// 隐藏手机号的中间四位
func hiddenMobilePhone(str: String) -> String {
    
    let start = str.index(str.startIndex, offsetBy: 3)
    let end = str.index(str.startIndex, offsetBy: 6)
    return str.replacingCharacters(in: start...end, with: "****")
}

/// 银行卡号处理
func hiddenCardID(str: String) -> String {
    
    let start = str.index(str.startIndex, offsetBy: 0)
    let end = str.index(str.startIndex, offsetBy: str.count - 5)
    return str.replacingCharacters(in: start...end, with: "尾号")
}

/** 获取label的height */
func getLabelHeight(labelStr: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
    
    let statusLabelText: NSString = labelStr as NSString
    
    let size = CGSize(width: width, height: 900)
    
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size
    
    return strSize.height
}

/** 获取label的width */
func getLabelWidth(labelStr: String, fontSize: CGFloat, height: CGFloat) -> CGFloat {
    
    let statusLabelText: NSString = labelStr as NSString
    
    let size = CGSize(width: 900, height: height)
    
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size
    
    return strSize.width
}

// MARK: 字符串拼接两位小数的float
/// 字符串拼接两位小数的float
/// - 柯里化
/// - Parameter addStr: 字符串
/// - Returns: float
func addTo02CGFloat(_ addStr: String) -> (CGFloat) -> String {
    
    return {
        tempStr in
        print(tempStr)
        return addStr + String(format: "%.2f", tempStr)
    }
}

// MARK: 输出几位小数的字符串
/// 输出几位小数的字符串
///
/// - Parameters:
///   - f: 几位小数
///   - str: 字符串
/// - Returns: 输出几位小数的字符串
func formata(_ f: String, str: Double) -> String {
    return String(format: "%\(f)f", str)
}

func timeCountdown(timeCountNum: Int ,asyncUIBlock: @escaping ((DispatchSourceTimer ,Int)->())) {
    
    // 定义需要计时的时间
    var timeCount = timeCountNum
    // 在global线程里创建一个时间源
    let codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
    // 设定这个时间源是每秒循环一次，立即开始
    codeTimer.scheduleRepeating(deadline: .now(), interval: .seconds(1))
    // 设定时间源的触发事件
    codeTimer.setEventHandler(handler: {
        // 每秒计时一次
        if timeCount > 1 {
            timeCount -= 1
        }else {
            timeCount = 0
            codeTimer.cancel()
        }
        // 返回主线程处理一些事件，更新UI等等
        DispatchQueue.main.async {
            asyncUIBlock(codeTimer,timeCount)
        }
    })
    // 启动时间源
    codeTimer.resume()
}

/// 时间戳转时间字符串 时间戳为秒级！！！（10位）
func timeStampToString(timeStamp:String)->String {
    
    let string = NSString(string: timeStamp)
    
    let timeSta:TimeInterval = string.doubleValue
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
    
    let date = NSDate(timeIntervalSince1970: timeSta)
    
    return dfmatter.string(from: date as Date)
}

/// 时间转时间戳 stirng
func stringToTimeStamp(stringTime:String)->String {
    
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
    let date = dfmatter.date(from: stringTime)
    let dateStamp:TimeInterval = date!.timeIntervalSince1970
    let dateSt:Int = Int(dateStamp)
    
    return String(dateSt)
}

/// 获取当前时间
///
/// - Returns: 返回当前时间字符串
func getCurrentTime() -> String {
    //获取当前时间
    let now = Date()
    
    // 创建一个日期格式器
    let dformatter = DateFormatter()
    dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
    return dformatter.string(from: now)
}



/// 延时
///
/// - Parameters:
///   - delay: 延时时间
///   - closure: 延时回调
func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

/// 监听通知
///
/// - Parameters:
///   - obs: 观察者
///   - sele: 方法
///   - name: 通知名称
func kAddNotification(obs: Any, sele: Selector, name: String) {
    
    NotificationCenter.default.addObserver(obs, selector: sele, name: Notification.Name(rawValue: name), object: nil)
}

/// 发送通知
///
/// - Parameters:
///   - name: 通知名称
///   - user: 传递参数
func kPostNotification(name: String, user: [AnyHashable : Any]?) {
    
    NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil, userInfo: user )
}

/// 移除通知
///
/// - Parameter obs: 观察者
func kRemoveNotification(obs: Any) {
    
    NotificationCenter.default.removeObserver(obs)
}


