//
//  CategoryListCell.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class CategoryListCell: UITableViewCell {
    
    @IBOutlet weak var userIcon: UIImageView!
    
    @IBOutlet weak var Title: UILabel!
    
    
    @IBOutlet weak var Desc: UILabel!
    
    
    @IBOutlet weak var Attention: UIButton!
    
    
    var categoryListModel:CategoryListModel! {
    
        didSet {
            let placeholder = UIImage(named: "defaultUserIcon")
            
            userIcon.sd_setImage(with: URL(string: categoryListModel.header!), placeholderImage: placeholder, options: SDWebImageOptions(rawValue: UInt(0)), progress: { (receivedSize, expectedSize) in
            }) { (image, error, cacheType, imageURL) in
                UIGraphicsBeginImageContextWithOptions((image?.size)!, true, 0.0)
                let imageW = self.userIcon.size.width
                let imageH = (image?.size.height)! * imageW / (image?.size.width)!
                image?.draw(in: CGRect(x: 0, y: 0, width: imageW, height: imageH))
                self.userIcon.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
            Title.text = categoryListModel.screen_name
            var subNumber:String!
            
            if categoryListModel.fans_count < 10000 {
                subNumber = String(format: "%ld人订阅",categoryListModel.fans_count)
            }else {
            
                subNumber = String(format: "%.lf万人关注",CGFloat(categoryListModel.fans_count / 10000))
            }
            
            Desc.text = subNumber
            
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
