//
//  PublishView.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/9.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class PublishView: UIView {

    
    var sloganView:UIImageView!
    
    var publishWindow:UIWindow!
    
    
    lazy var imagesArr:Array! = { () -> [String] in 
        
       let array = ["publish-video","publish-picture","publish-text","publish-audio","publish-review","publish-offline"]
        return array
    }()
    
    lazy var titlesArr:Array! = { () -> [String] in 
    
        let array = ["发视频","发图片","发段子","发音频","审贴","离线下载"]
        
        return array
    }()
    
    
    @IBAction func buttonClick(_ sender: UIButton) {
        cancelWithCompletionBlock {
            
        }
    }
    
    func show() {
    
//        let publishView = Bundle.main.loadNibNamed("PublishView", owner: nil, options: nil)?.first as! PublishView
        
        publishWindow = UIWindow()
        publishWindow.frame = UIScreen.main.bounds
        publishWindow.backgroundColor = UIColor.init(white: 1.0, alpha: 0.8)
        publishWindow.isHidden = false
        self.frame = publishWindow.bounds
        publishWindow.addSubview(self)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = false
        setupButtons()
    }
    
    func setupButtons() {
        let maxCols = 3
        let buttonW = 72
        let buttonH = buttonW + 30
        let buttonStartX = 15
        let buttonMargx = (ConstTool.instance.kScreenW - CGFloat(maxCols * buttonW) - 2 * CGFloat(buttonStartX)) / CGFloat(maxCols - 1)
        let buttonStartY = (ConstTool.instance.kScreenH - 2 * CGFloat(buttonH)) / CGFloat(2)
        for  i in 0 ..< imagesArr.count {
            let button = VerticalButton(type: .custom)
            let row = i / maxCols
            let col = i % maxCols
            let buttonX = CGFloat(buttonStartX) + (buttonMargx + CGFloat(buttonW)) * CGFloat(col)
            
            let buttonEndY = buttonStartY + CGFloat(row) * CGFloat(buttonH)
            button.setImage(UIImage(named:imagesArr[i]), for: .normal)
            button.setTitle(titlesArr[i], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            addSubview(button)
            button.addTarget(self, action: #selector(PublishView.clickButton(button:)), for: .touchUpInside)
            
            button.tag = i
            let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            animation?.fromValue = NSValue.init(cgRect: CGRect(x: buttonX, y: CGFloat(buttonH) - ConstTool.instance.kScreenH, width: CGFloat(buttonW), height: CGFloat(buttonH)))
            animation?.toValue = NSValue.init(cgRect: CGRect(x: buttonX, y: CGFloat(buttonEndY), width: CGFloat(buttonW), height: CGFloat(buttonH)))
            animation?.springBounciness = 5
            animation?.springSpeed = 15
            animation?.beginTime = CACurrentMediaTime() + CFTimeInterval(0.1 * CGFloat(i))
            button.pop_add(animation, forKey: nil)
        }
        
        sloganView = UIImageView(image: UIImage(named: "app_slogan"))
        
        addSubview(sloganView)
        
        let centerX:CGFloat = ConstTool.instance.kScreenW * 0.5
        let centerEndY:CGFloat = ConstTool.instance.kScreenH * 0.2
        let centerBeginY:CGFloat = centerEndY - ConstTool.instance.kScreenH
        let animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
        animation?.fromValue = NSValue.init(cgPoint: CGPoint(x: centerX, y: centerBeginY))
        animation?.toValue = NSValue.init(cgPoint: CGPoint(x: centerX, y: centerEndY))
        animation?.springBounciness = 5
        animation?.springSpeed = 15
        animation?.beginTime = CACurrentMediaTime() + CFTimeInterval(0.1 * CGFloat(imagesArr.count))
        animation?.completionBlock = { (animation,finished) in
        
        self.isUserInteractionEnabled = true
        }
        sloganView.pop_add(animation, forKey: nil)
    }
    
    func clickButton(button:VerticalButton) {
        
        
    }
    
    func cancelWithCompletionBlock(complentionBlock: @escaping ()->Void) {
        isUserInteractionEnabled = false
        for i in 1 ..< subviews.count {
        
            let subview = subviews[i]
            
            let animation = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            
            let centerY:CGFloat = subview.centerY + ConstTool.instance.kScreenH
            
            animation?.springBounciness = 5
            animation?.springSpeed = 15
            animation?.toValue = NSValue.init(cgPoint: CGPoint(x: subview.centerX, y: centerY))
            animation?.beginTime = CACurrentMediaTime() + CFTimeInterval(CGFloat(i - 2) * 0.1)
            
            subview.pop_add(animation, forKey: nil)
            
            if i == subviews.count - 1 {
                animation?.completionBlock = {(animation,finished) in
                
                    self.removeFromSuperview()
                    self.publishWindow.isHidden = true
                    self.publishWindow = nil
                    
                }
            }
        }
    }
    

    
}
