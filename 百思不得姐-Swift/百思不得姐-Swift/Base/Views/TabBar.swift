//
//  TabBar.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit


class TabBar: UITabBar {

    var publishButton:UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundImage = UIImage(named: "tabbar-light")
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named:"tabBar_publish_icon"), for: .normal)
        button.setBackgroundImage(UIImage(named:"tabBar_publish_click_icon"), for: .highlighted)
        button.size = (button.currentBackgroundImage?.size)!
        addSubview(button)
        publishButton = button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        publishButton?.center = CGPoint(x: width * 0.5, y: height * 0.5)
        let buttonY:CGFloat = 0
        let buttonW = width / 5
        let buttonH = height
        var index:Int = 0
        var buttonX:CGFloat = 0

        for  button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!){
                continue
            }            
            buttonX = buttonW * CGFloat((index > 1 ? index + 1 : index))
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            index += 1
        }
        
        publishButton?.addTarget(self, action: #selector(TabBar.publishButtonClick), for: .touchUpInside)
        
    }
    
    @objc private func publishButtonClick() {
    
        let publishView = Bundle.main.loadNibNamed("PublishView", owner: nil, options: nil)?.first as! PublishView

        publishView.show()
    }

}
