//
//  TopicCell.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/31.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var createTimeLabel: UILabel!
    
    @IBOutlet weak var sina_addV: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var topCmtView: UIView!
    
    @IBOutlet weak var topCmtContentLabel: UILabel!
    
    @IBOutlet weak var dingButton: UIButton!
    
    @IBOutlet weak var caiButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    lazy var pictureView:TopicPicture = {
    
        let picture = Bundle.main.loadNibNamed("TopicPicture", owner: nil, options: nil)?.first as? TopicPicture
        return picture!
    }()
    
    lazy var voiceView: VoiceView = {
    
        let voice = Bundle.main.loadNibNamed("VoiceView", owner: nil, options: nil)?.first as? VoiceView
        
        return voice!
    }()
    
    lazy var videoView:TopicVideoView = {
    
        let video = Bundle.main.loadNibNamed("TopicVideoView", owner: nil, options: nil)?.first as? TopicVideoView
        
        return video!
    }()
    
    var topicModel:TopicModel! {
    
        didSet {
        
            sina_addV.isHidden = !topicModel.sina_v
            
            let placeholdImage = UIImage(named:"defaultUserIcon")
            
            
            profileImageView.sd_setImage(with: URL(string: topicModel.profile_image!), placeholderImage: placeholdImage!, options: SDWebImageOptions(rawValue: UInt(0)), progress: { (receivedSize, expectedSize) in
                
                
            }) { (image, error, cacheType, imageURL) in
                
                self.profileImageView.image = image != nil ? ConstTool.instance.circleImage(oldImage: image) : ConstTool.instance.circleImage(oldImage: placeholdImage!)
            }
            
        
            nameLabel.text = topicModel.name
            createTimeLabel.text = topicModel.create_time
            contentLabel.text = topicModel.text
            updateButton(button: dingButton, count: topicModel.ding, placeholder: "赞")
            updateButton(button: caiButton, count: topicModel.cai, placeholder: "踩")
            updateButton(button: shareButton, count: topicModel.repost, placeholder: "分享")
            updateButton(button: commentButton, count: topicModel.comment, placeholder: "评论")
            
            if topicModel.type == 10 {//图片
                pictureView.isHidden = false
                voiceView.isHidden = true
                videoView.isHidden = true
                pictureView.frame = topicModel.pictureF
                pictureView.topicModel = topicModel
                
            }else if(topicModel.type == 31) {//声音
                voiceView.isHidden = false
                pictureView.isHidden = true
                videoView.isHidden = true
                voiceView.frame = topicModel.voiceF
                voiceView.topicModel = topicModel
            
            }else if(topicModel.type == 41) {//视频
            
                videoView.isHidden = false
                pictureView.isHidden = true
                voiceView.isHidden = true
                videoView.frame = topicModel.videoF
                videoView.topicModel = topicModel
            }else {//其他
           
                pictureView.isHidden = true
                voiceView.isHidden = true
                videoView.isHidden = true
                
            }
            if topicModel.top_cmt != nil {
                topCmtView.isHidden = false
                topCmtContentLabel.text = String(format: "%@ : %@", (topicModel.top_cmt?.user?.username)!,(topicModel.top_cmt?.content)!)
            }else {
            
                topCmtView.isHidden = true
            }
            
//            var newFrame = self.frame
//            newFrame.origin.x += ConstTool.instance.TopicMargin
//            newFrame.size.width -= 2 * ConstTool.instance.TopicMargin
//            newFrame.origin.y += ConstTool.instance.TopicMargin
//            newFrame.size.height = topicModel.cellHeight - ConstTool.instance.TopicMargin
//            self.frame = newFrame

        }
    }
    
    func updateButton(button:UIButton,count:NSInteger, placeholder:String) {
        var placeholder = placeholder
        if count > 10000 {
            placeholder = String(format: "%.1fzd万", count / 10000)
        }else if (count > 0) {
        
            placeholder = String(format: "%zd", count)
        }
        button.setTitle(placeholder, for: .normal)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        contentView.addSubview(self.pictureView)
        contentView.addSubview(self.voiceView)
        contentView.addSubview(self.videoView)
        self.contentLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
