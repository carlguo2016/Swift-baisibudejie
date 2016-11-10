//
//  ProfileCell.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        let backImageView = UIImageView()
        backImageView.image = UIImage(named: "mainCellBackground")
        backgroundView = backImageView
        textLabel?.textColor = UIColor.darkGray
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView?.image == nil {
            return
        }
        imageView?.width = 30
        imageView?.height = (imageView?.width)!
        imageView?.centerY = self.height * 0.5
        
        textLabel?.x = (imageView?.frame.maxX)! + ConstTool.instance.TopicMargin
    }

}
