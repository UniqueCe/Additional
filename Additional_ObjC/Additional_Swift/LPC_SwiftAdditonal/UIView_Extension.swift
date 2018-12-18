//
//  UIView_Extension.swift
//  Alert_Swift
//
//  Created by lzhl_iOS on 2017/3/27.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK:Frame Origin
    var Origin_x: CGFloat {
        
        get {
            return frame.origin.x
        } set {
            frame.origin.x = newValue
        }
    }
    
    var Origin_y: CGFloat {
        
        get {
            return frame.origin.y
        } set {
            frame.origin.y = newValue
        }
    }
    
    //MARK:Frame Size
    var Size_width: CGFloat {
        
        get {
            return frame.size.width
        } set {
            frame.size.width = newValue
        }
    }
    
    var Size_height: CGFloat {
        
        get {
            return frame.size.height
        } set {
            frame.size.height = newValue
        }
    }
    
    //MARK:Center
    var CenterX : CGFloat {
        
        get {
            return center.x
        } set {
            center.x = newValue
        }
    }
    
    var CenterY : CGFloat {
        
        get {
            return center.y
        } set {
            center.y = newValue
        }
    }
    
    //MARK:Frame
    var Size : CGSize {
        
        get {
            return frame.size
        } set {
            frame.size = newValue
        }
    }
    
    var Origin : CGPoint {
        
        get {
            return frame.origin
        } set {
            frame.origin = newValue
        }
    }
    
    var maxX: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        } set {
            var fr = self.frame
            fr.origin.x = newValue - frame.size.width
            self.frame = fr
        }
    }
    
    var maxY: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        } set {
            var fr = self.frame
            fr.origin.y = newValue - frame.size.height
            self.frame = fr
        }
    }
    
    func GetViewController() -> UIViewController {
        
        //1.通过响应者链关系，取得此视图的下一个响应者
        var Next:UIResponder?
        Next = self.next!
        repeat {
            //2.判断响应者对象是否是视图控制器类型
            if ((Next as?UIViewController) != nil) {
                return (Next as! UIViewController)
            }else {
                Next = Next?.next
            }
            
        } while Next != nil
        
        return UIViewController()
    }
    
    //切圆角
    /// 边框
    ///
    /// - Parameters:
    ///   - cornersSize: 圆角
    ///   - pathSize: 罩层大小
    ///   - lineWidth: 线宽
    ///   - strokeColoe: 线颜色
    ///   - backColor: 背景色
    private func setAllCornerWithRounded(cornersSize: CGFloat, pathSize: CGSize, lineWidth: CGFloat, strokeColor: UIColor?, backColor: UIColor?) {
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: pathSize.width, height: pathSize.height), cornerRadius: cornersSize)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: pathSize.width, height: pathSize.height)
        maskLayer.path = maskPath.cgPath
        
        if strokeColor != nil {
            
            let borderLayer = CAShapeLayer()
            borderLayer.frame = CGRect(x: 0, y: 0, width: pathSize.width, height: pathSize.height)
            borderLayer.lineWidth = lineWidth
            borderLayer.strokeColor = strokeColor!.cgColor
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.path = maskPath.cgPath
            self.layer.insertSublayer(borderLayer, at: 0)
            self.layer.backgroundColor = backColor?.cgColor
        }
        self.layer.mask = maskLayer
    }
    
    /// 设置圆角(宽度默认为1,无边框颜色)
    ///
    /// - Parameters:
    ///   - cornersSize: 圆角大小
    ///   - pathSize: 罩层尺寸
    func setAllCornerWithRoundedCornersSize(cornersSize: CGFloat, pathSize: CGSize) {
        
        setAllCornerWithRounded(cornersSize: cornersSize, pathSize: pathSize, lineWidth: 1, strokeColor: nil, backColor: UIColor.white)
    }
    
    /// 设置圆角及边框颜色(宽度默认为1,背景色默认为白色)
    ///
    /// - Parameters:
    ///   - cornersSize: 圆角大小
    ///   - pathSize: 罩层尺寸
    ///   - strokeColor: 边框颜色
    func setAllCornerWithRoundedAndABorderCornersSize(cornersSize: CGFloat, pathSize: CGSize, strokeColor: UIColor) {
        
        setAllCornerWithRounded(cornersSize: cornersSize, pathSize: pathSize, lineWidth: 1, strokeColor: strokeColor, backColor: UIColor.white)
    }
    
    /// 设置圆角及边框颜色(背景色默认为白色)
    ///
    /// - Parameters:
    ///   - cornersSize: 圆角大小
    ///   - pathSize: 罩层尺寸
    ///   - lineWidth: 线宽
    ///   - strokeColor: 边框颜色
    func setAllCornerWithRounded_ABorder_LineWidthCornersSize(cornersSize: CGFloat, pathSize: CGSize, lineWidth: CGFloat, strokeColor: UIColor) {
        
        setAllCornerWithRounded(cornersSize: cornersSize, pathSize: pathSize, lineWidth: lineWidth, strokeColor: strokeColor, backColor: UIColor.white)
    }
    
    
    /// 设置圆角及边框颜色(宽度默认为1)
    ///
    /// - Parameters:
    ///   - cornersSize: 圆角大小
    ///   - pathSize: 罩层尺寸
    ///   - lineWidth: 线宽
    ///   - strokeColor: 边框颜色
    ///   - backColor: 背景色
    func setAllCornerRounded_ABorder_LineWidth_backColor(cornersSize: CGFloat, pathSize: CGSize, strokeColor: UIColor?, backColor: UIColor?) {
        
        setAllCornerWithRounded(cornersSize: cornersSize, pathSize: pathSize, lineWidth: 1, strokeColor: strokeColor, backColor: backColor)
    }
    
    /// 画矩形圆弧
    func setDrawRectangleArc()  {
        
        let finalSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        let layerHeight = finalSize.height - 60
        let layer = CAShapeLayer()
        let bezier = UIBezierPath()
        
        bezier.move(to: CGPoint(x: 0, y: finalSize.height - layerHeight))
        bezier.addLine(to: CGPoint(x: 0, y: finalSize.height))
        bezier.addLine(to: CGPoint(x: finalSize.width, y: finalSize.height))
        bezier.addLine(to: CGPoint(x: finalSize.width, y: finalSize.height - layerHeight))
        bezier.addQuadCurve(to: CGPoint(x: 0, y: finalSize.height - layerHeight), controlPoint: CGPoint(x: finalSize.width / 2, y: finalSize.height - layerHeight - 50))
        layer.path = bezier.cgPath
        layer.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(layer)
    }
    
    // MARK: view添加点击手势！
    func viewTapGestureClickAction(Target:Any?, Action: Selector?) {
        
        let tap = UITapGestureRecognizer(target:Target, action: Action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
}


extension UIImageView {
    
    //MAKR:返回屏幕截图
    func snapShotImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let result: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        return result
    }
}
