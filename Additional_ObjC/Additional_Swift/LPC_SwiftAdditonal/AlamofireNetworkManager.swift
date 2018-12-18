//
//  AlamofireNetworkManager.swift
//  GoldUnionSwift
//
//  Created by lzhl_iOS on 2018/11/29.
//  Copyright © 2018年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit
import Alamofire


enum AlamofireRequestType {
    case GET
    case POST
}

class AlamofireNetworkManager: NSObject {

    static let sharedManager: AlamofireNetworkManager = {
        let tools = AlamofireNetworkManager()
        return tools;
    }()
    
    let manager = NetworkReachabilityManager(host: "www.baidu.com")
    
    //MARK: Get & Post 请求
    private func request(type: AlamofireRequestType ,url: String ,parame: [String: Any] , completionHandlerBlack: @escaping ((DataResponse<Any>?)->())) {
        
        if type == .GET {
            Alamofire.request(url, method: .post, parameters: parame).responseJSON { (response) in
                completionHandlerBlack(response)
            }
        }else {
            Alamofire.request(url, method: .post, parameters: parame).responseJSON { (response) in
                completionHandlerBlack(response)
            }
        }
    }
    
    //MARK: 检测网络类型
    func checkNetwork() {
        
        manager?.listener = { status in
            
            switch status{
            case .notReachable:
                print("网络无法访问")
            case .unknown:
                print("未知网络")
            case .reachable(.ethernetOrWiFi):
                print("通过WiFi链接")
            case .reachable(.wwan):
                print("通过移动网络链接")
            }
        }
        manager?.startListening()
    }
    
    //MARK: 上传单张图片
    func requestUpLoadImage(url: String,
                            parames: [String: String],
                            image: UIImage,
                            completionHandlerBlack: @escaping ((DataResponse<Any>?)->()),
                            progressBlack: @escaping((Progress)->()),
                            failuBlack: @escaping((Error?)->())) {
        
        Alamofire.upload(multipartFormData: { (formData) in
            
            let data = UIImageJPEGRepresentation(image, 0.5)
            let fileName = String.init(describing: NSDate()) + ".png"
            
            // withName:：是根据文档决定传入的字符串
            formData.append(data!, withName: "photo", fileName: fileName, mimeType: "image/png")
            // 遍历添加参数
            for (key, value) in parames {
                // string 转 data
                formData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: url) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    completionHandlerBlack(response)
                })
                upload.uploadProgress(closure: { (progress) in
                    print("进度、\(progress.fractionCompleted)")
                    progressBlack(progress)
                })
            case .failure(let error):
               failuBlack(error)
            }
        }
    }
    
//    //MARK: 共用接口！ 加密！
//    func requestCommonsPublicURL(url: String ,parame: [String: Any] , completionHandlerBlack: @escaping ((DataResponse<Any>?)->())) {
//        
//        let str: String = commonTool().getJSONStringFromDictionary(dictionary: parame as NSDictionary)
//        let jsonData: String = EncryptionAndDecryption().encryptUseDES(str, key: "lianlian")
//        let parDict:Dictionary<String,Any> = ["data":jsonData]
//        
//        request(type: .POST, url: url, parame: parDict, completionHandlerBlack: completionHandlerBlack)
//    }
    
    
    
    
    
    
    
    
    
    deinit {
        manager?.stopListening()
    }
}
