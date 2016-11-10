//
//  MyProgressView.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/11/1.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit


class MyProgressView: DALabeledCircularProgressView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        progressLabel.textColor = UIColor.white
        roundedCorners = Int(2.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        progressLabel.textColor = UIColor.white
        roundedCorners = Int(2.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setProgress(_ progress: CGFloat, animated: Bool) {
        super.setProgress(progress, animated: animated)
        var text = NSString(format: "%.0f%%", progress * CGFloat(100))
        text = text.replacingOccurrences(of: "-", with: "") as NSString
        progressLabel.text = text as String
    }
    
}
