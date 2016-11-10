//
//  TitleIndicatorView.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/31.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

protocol TitleIndicatorViewDelegate:NSObjectProtocol {
    func didClickItem(titleIndicatorView:TitleIndicatorView,button:UIButton)
}

class TitleIndicatorView: UIView {

    weak var delegate:TitleIndicatorViewDelegate?
    
    weak var selectedButton:UIButton!
    
    var indicatorView:UIView!
    
    lazy var titles:[String] = {
        let array = ["全部","视频","声音","图片","段子"]
        return array
    }()
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white.withAlphaComponent(0.7)
       indicatorView = UIView()
       selectedButton = UIButton(type: .custom)
       setupAllSubViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        setupAllSubViews()
    }
    
    private func setupAllSubViews() {
        indicatorView.height = 2
        indicatorView.y = height - indicatorView.height
        indicatorView.backgroundColor = UIColor.red
        let buttonWidth = width / CGFloat(titles.count)
        let buttonHeight = height
        
        for i in 0 ..< titles.count {
        
            let button = UIButton(type: .custom)
            button.width = buttonWidth
            button.height = buttonHeight
            button.x = buttonWidth * CGFloat(i)
            button.tag = i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.setTitleColor(UIColor.red, for: .disabled)
            button.addTarget(self, action: #selector(TitleIndicatorView.titleButtonDidClick(button:)), for: .touchUpInside)
            addSubview(button)
            if  i == 0 {
                button.titleLabel?.sizeToFit()
                button.isEnabled = false
                selectedButton = button
                indicatorView.width = (button.titleLabel?.width)!
                indicatorView.centerX = button.centerX
            }
            
        }
        addSubview(indicatorView)
    }
    
    @objc private func titleButtonDidClick(button:UIButton) {
        delegate?.didClickItem(titleIndicatorView: self, button: button)
    }
    
}
