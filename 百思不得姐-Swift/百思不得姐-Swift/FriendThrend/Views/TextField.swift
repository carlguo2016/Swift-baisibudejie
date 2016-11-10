//
//  TextField.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class TextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        tintColor = textColor
        
        let resign = resignFirstResponder()
        
        print(resign)
        
    }
    
    override func becomeFirstResponder() -> Bool {
        setValue(textColor, forKeyPath: "_placeholderLabel.textColor")
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        return super.resignFirstResponder()
    }

}
