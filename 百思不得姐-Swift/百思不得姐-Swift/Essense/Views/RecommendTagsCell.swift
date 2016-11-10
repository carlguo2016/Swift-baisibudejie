//
//  RecommendTagsCell.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/9.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class RecommendTagsCell: UITableViewCell {

    
    @IBOutlet weak var tagIcon: UIImageView!
    
    @IBOutlet weak var tagSubScribe: UIButton!
    
    @IBOutlet weak var tagTitle: UILabel!
    
    
    @IBOutlet weak var tagFans: UILabel!
    
    
    var tagModel:RecommendTagsModel! {
    
        didSet {
            
            tagIcon.sd_setImage(with: URL(string: tagModel.image_list!), placeholderImage:nil, options: SDWebImageOptions(rawValue: UInt(0)), progress: { (receivedSize, expectedSize) in
                
                
            }) { (image, error, cacheType, imageURL) in
                
                self.tagIcon.image = image != nil ? ConstTool.instance.circleImage(oldImage: image) : ConstTool.instance.circleImage(oldImage:nil)
            }

            tagTitle.text = tagModel.theme_name
            var  subNumber:String!;
            if (tagModel.sub_number < 10000) {
                subNumber = String(format: "%ld人订阅", tagModel.sub_number)
            }else {
                subNumber = String(format: "%.lf万人订阅", Float(tagModel.sub_number / 10000))
            }
           tagFans.text = subNumber ;
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
