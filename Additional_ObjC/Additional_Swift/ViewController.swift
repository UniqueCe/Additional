//
//  ViewController.swift
//  Additional_Swift
//
//  Created by 刘培策 on 17/4/5.
//  Copyright © 2017年 UniqueCe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.setupUILabel()
//
//        self.setupColor()
//
//        self.setupButton()
        
    }

    @IBAction func asdw(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController.alertController(title: "哈哈", message: "内容是哈哈哈家伙",actionTitle: "取消", handlerClosures: nil)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func qwe(_ sender: Any) {
    
        let alert: UIAlertController = UIAlertController.alertController(title: "哈哈", message: "内容是哈哈哈家伙",actionTitle: "", handlerClosures: nil)
        let action = UIAlertAction(title: "haha", style: .destructive, handler: nil)
        
        let action2 = UIAlertAction(title: "haha2", style: .cancel, handler: nil)
        
        let action3 = UIAlertAction(title: "haha3", style: .default, handler: nil)
        
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(action3)
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func tiuyiu(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController.actionSheetController(title: "哈哈", message: "内容是哈哈哈家伙",actionTitle: "取消", handlerClosures: nil)
        
        self.present(alert, animated: true, completion: nil)

    }
    
    
    @IBAction func gkhj(_ sender: Any) {
        
        let alert: UIAlertController = UIAlertController.actionSheetController(title: "哈哈", message: "内容是哈哈哈家伙",actionTitle: nil, handlerClosures: nil)
        
        let action2 = UIAlertAction(title: "haha2", style: .cancel, handler: nil)
        
        let action3 = UIAlertAction(title: "haha3", style: .default, handler: nil)
        
        alert.addAction(action2)
        alert.addAction(action3)
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
    //MAKR:返回屏幕截图
    func snapShotImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        return result
    }
    
    func setupUILabel() {
        
        let label = UILabel(text: "haha", fontSize: 20, textColor: .red)
        label.frame = CGRect(x: 200, y: 330, width: 100, height: 50)
        
        view.addSubview(label)
    }
    
    func setupColor() {
        
        let v1 = UIView(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
        let v2 = UIView(frame: CGRect(x: 200, y: 260, width: 50, height: 50))
        let v3 = UIView(frame: CGRect(x: 200, y: 130, width: 50, height: 50))
        
        v1.backgroundColor = UIColor.colorWithHex(hex: 0xc9221c)
        v2.backgroundColor = UIColor.colorWithRGB(R: 180, G: 22, B: 30, alpha: 0.5)
        v3.backgroundColor = UIColor.colorWithRandomColor()
        
        view.addSubview(v1)
        view.addSubview(v2)
        view.addSubview(v3)
    }
    
    func setupButton() {
        
        let btn = UIButton.buttonWithTitleBtn(title: "haha", selecteTitle: "xixi", titleColor: UIColor.red, titleSelecteColor: UIColor.orange)
        
        btn.frame = CGRect(x: 270, y: 50, width: 50, height: 50)
        btn.addTarget(self, action: #selector(gotoAction(_:)), for: .touchUpInside)
        view.addSubview(btn)
        
        
        let btn2 = UIButton.buttonWithImageBtn(image: "喵猫", selecteImage: "猴怪")
        btn2.frame = CGRect(x: 270, y: 120, width: 50, height: 50)
        btn2.addTarget(self, action: #selector(gotoAction(_:)), for: .touchUpInside)
        view.addSubview(btn2)
        
        
        let btn22 = UIButton.buttonWithTitleAndBackgroundColorBtn(title: "nicai", selecteTitle: "asdqe", titleColor: UIColor.blue, titleSelecteColor: UIColor.green, backgroundColor: UIColor.purple)
        btn22.frame = CGRect(x: 270, y: 190, width: 50, height: 50)
        btn22.setTitleShadowColor(UIColor.yellow, for: .normal)
        btn22.setTitleShadowColor(UIColor.orange, for: .selected)
        btn22.addTarget(self, action: #selector(gotoAction(_:)), for: .touchUpInside)
        view.addSubview(btn22)
        
        
        let btn23 = UIButton.buttonWithTitleAndBackgroundImageBtn(title: "ni好", selecteTitle: "不好", titleColor: UIColor.red, titleSelecteColor: UIColor.black, backgroundImage: "喵猫", backgroundSelecteImage: "猴怪")
        btn23.frame = CGRect(x: 270, y: 250, width: 50, height: 50)
        btn23.addTarget(self, action: #selector(gotoAction(_:)), for: .touchUpInside)
        view.addSubview(btn23)

        
        
    }
    
    func gotoAction(_ sender:UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        timeCountdown(timeCountNum: 5) { (dis, count) in
            print(count)
        }
        
        let si:CGFloat = getLabelHeight(labelStr: "难啊", fontSize: 15, width: 200)
        let si2:CGFloat = getLabelWidth(labelStr: "难啊", fontSize: 15, height: 200)
        print(si)
        print(si2)
    }
    
    
    
    
    
    
    
    


}

