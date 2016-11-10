//
//  TopicVideoView.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/2.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class TopicVideoView: UIView {
    @IBOutlet weak var videoImageView: UIImageView!

    @IBOutlet weak var playCountLabel: UILabel!

    @IBOutlet weak var videoTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
    }
    
    var topicModel:TopicModel! {
    
        didSet {
        
            videoImageView.sd_setImage(with: URL(string:topicModel.large_image!), completed: nil
            )
            playCountLabel.text = String(format: "%zd播放", topicModel.plycount)
            let minute = topicModel.videotime / 60
            let second = topicModel.videotime % 60
            videoTimeLabel.text = String(format: "%02zd:%02zd", minute,second)
            
            
        }
    }
    
    
    
    @IBAction func playVideo(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
}
