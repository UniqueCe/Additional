//
//  imagePickerManager.swift
//  GoldUnionSwift
//
//  Created by lzhl_iOS on 2018/1/17.
//  Copyright © 2018年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit

protocol imagePickerManagerDelegate: class {
    
    /** 获取图片回调 */
    func selectImageFinished(_ image:UIImage)
    /** 取消 */
    func imageCanel()
}

class imagePickerManager: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    /** 拍照用系统UIImagePickerController*/
    private var imagePickerController:UIImagePickerController!
    
    weak var delegate: imagePickerManagerDelegate?
    
    private var image: UIImage?
    
    override init() {
        super.init()
        
        cameraReady()
    }
    
    private func cameraReady(){
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
    }
    /** 调取相册和相机 */
    func showCamera(sourceType: UIImagePickerControllerSourceType, callBack: @escaping ((UIImagePickerController?)->()))  {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController!.sourceType = sourceType
            callBack(imagePickerController)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        delegate?.selectImageFinished(image!)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        delegate?.imageCanel()
    }
}
