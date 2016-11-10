//
//  TopicCommentCell.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/2.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class TopicCommentCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var sexImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var likeNumLabel: UILabel!
    
    @IBOutlet weak var commentContentLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainCellBackground")
        backgroundView = imageView
        
    
    }
    
    override var frame: CGRect {
    
        didSet {
        
            frame.origin.x = ConstTool.instance.TopicMargin
            frame.size.width -= 2 * frame.origin.x
            super.frame = frame
        }
    }
    
    var commentModel:CommentModel! {
    
        didSet {
            
            let placeholdImage = UIImage(named:"defaultUserIcon")
            
            
            userImageView.sd_setImage(with: URL(string: commentModel.user!.profile_image!), placeholderImage: placeholdImage!, options: SDWebImageOptions(rawValue: UInt(0)), progress: { (receivedSize, expectedSize) in
                
                
            }) { (image, error, cacheType, imageURL) in
                
                self.userImageView.image = image != nil ? ConstTool.instance.circleImage(oldImage: image) : ConstTool.instance.circleImage(oldImage: placeholdImage!)
            }
            
            if commentModel.user?.sex! == ConstTool.instance.Male {
                sexImageView.image = UIImage(named: "Profile_manIcon")
            }else {
            
                sexImageView.image = UIImage(named: "Profile_womanIcon")
            }
            
            userNameLabel.text = commentModel.user?.username
            likeNumLabel.text = String(format: "%zd", commentModel.like_count)
            commentContentLabel.text = commentModel.content
            
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
