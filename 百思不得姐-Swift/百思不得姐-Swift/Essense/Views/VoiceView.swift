//
//  VoiceView.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/11/1.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class VoiceView: UIView {

    @IBOutlet weak var voiceImageView: UIImageView!
    
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var voiceTimeLabel: UILabel!
    
    
    var topicModel:TopicModel! {
        didSet {
        
            voiceImageView.sd_setImage(with: URL(string:topicModel.large_image!), completed: nil)
            playCountLabel.text = String(format: "%zd播放", topicModel.plycount)
            let minute = topicModel.voicetime / 60
            
            let second = topicModel.voicetime % 60
            
            voiceTimeLabel.text = String(format: "%02zd:%02zd", minute,second)
            
            
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
    }
    
    
    
    //点击播放按钮
    @IBAction func playButtonClick(_ sender: UIButton) {
    }
    
}
