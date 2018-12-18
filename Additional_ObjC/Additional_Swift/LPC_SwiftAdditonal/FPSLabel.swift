//
//  FPSLabel.swift
//  FPSLabel
//
//  Created by lzhl_iOS on 2018/6/4.
//  Copyright © 2018年 lzhl_iOS. All rights reserved.
//

import UIKit

let kSize = CGSize(width: 55, height: 20)

class FPSLabel: UILabel {

    private lazy var link = CADisplayLink(target: self, selector: #selector(tick(_:)))
    
    private lazy var count = NSInteger()
    
    private lazy var lastTime = TimeInterval()
    
    init() {
        super.init(frame: CGRect.zero)
        if frame.width == 0 && frame.height == 0 {
            frame = CGRect(x: 100, y: 40, width: 60, height: 25)
        }
        setupFPSLabelUI()
    }

    func setupFPSLabelUI() {
        
        layer.cornerRadius = 5
        clipsToBounds = true
        textAlignment = .center
        isUserInteractionEnabled = false
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        font = UIFont(name: "Courier", size: 14)
        
        link.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        return kSize
    }
    
    @objc private func tick(_ tempLink: CADisplayLink) {
     
        let fps: CGFloat
        
        if lastTime == 0 {
            lastTime = tempLink.timestamp
            return
        }
        
        count += 1
        let delta = tempLink.timestamp - lastTime
        if delta < 1 {
            return
        }else {
            lastTime = tempLink.timestamp
            fps = CGFloat(Double(count) / delta)
            count = 0
        }
        
        let progress: CGFloat = fps / 60.0
        let color = UIColor(hue: 0.27 * (progress - 0.2), saturation: 1.0, brightness: 0.9, alpha: 1)
        
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(Int(round(fps))) FPS"))
        
        text.setAttributes([NSForegroundColorAttributeName: color], range: NSRange(location: 0, length: text.length - 3))
        text.setAttributes([NSForegroundColorAttributeName: UIColor.white], range: NSRange(location: text.length - 3, length: 3))
    
        attributedText = text
    }
    
    deinit {
        link.invalidate()
    }
}







