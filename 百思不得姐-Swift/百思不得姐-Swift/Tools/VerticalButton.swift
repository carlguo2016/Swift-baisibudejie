//
//  VerticalButton.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/9.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setup()
    }
    
    func setup() {
        titleLabel?.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.x = 0
        imageView?.y = 0
        imageView?.width = self.width
        imageView?.height = (imageView?.width)!
        titleLabel?.x = 0
        titleLabel?.y = (imageView?.height)!
        titleLabel?.width = self.width
        titleLabel?.height = self.height - (titleLabel?.y)!
    }
    
}
