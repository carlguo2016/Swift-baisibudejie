//
//  Window.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit


class Window: UIWindow {

    static let window_:UIWindow = UIWindow()
    
    class func show() {
    
        window_.isHidden = false
    }
    
    class func hide() {
        window_.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        windowLevel = UIWindowLevelAlert
        rootViewController = TopWindowController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   override var frame: CGRect {
    
        didSet {
            var newFrame = frame
            newFrame = UIApplication.shared.statusBarFrame
            super.frame = newFrame
        }
    }
}
