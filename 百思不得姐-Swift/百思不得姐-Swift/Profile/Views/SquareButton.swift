//
//  SquareButton.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class SquareButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.y = self.height * 0.1
        imageView?.width = self.width * 0.5
        imageView?.height = (self.imageView?.width)!
        imageView?.centerX = self.width * 0.5
        
        titleLabel?.x = 0
        titleLabel?.y = (self.imageView?.frame.maxY)!
        titleLabel?.width = self.width
        titleLabel?.height = self.height - (self.titleLabel?.y)!
    }
    
    func setup() {
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        setTitleColor(UIColor.darkGray, for: .normal)
        setBackgroundImage(UIImage(named:"mainCellBackground"), for: .normal)
    }
    
    override var isHighlighted: Bool {
    
        didSet {
        
        }
    }
    
    var squareModel:SquareModel! {
    
        didSet {
        
            self.sd_setImage(with: URL(string:squareModel.icon!), for: .normal)
            setTitle(squareModel.name, for: .normal)
        }
    }
    
}
