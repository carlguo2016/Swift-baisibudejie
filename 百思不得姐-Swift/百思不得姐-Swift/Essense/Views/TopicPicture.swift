//
//  TopicPicture.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/11/1.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class TopicPicture: UIView {

    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var GifView: UIImageView!
    
    @IBOutlet weak var seeBigButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        pictureImageView.isUserInteractionEnabled = true
        pictureImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(TopicPicture.showBigImage)))
    }
    
  
    func showBigImage()  {
        
    }
    
    var topicModel:TopicModel! {
    
        didSet {

//            progressView.setProgress(topicModel.pictureProgress, animated: true)
            pictureImageView.sd_setImage(with: URL(string: topicModel.large_image!), placeholderImage: nil, options: SDWebImageOptions(rawValue: UInt(0)), progress: { (receivedSize, expectedSize) in
//                self.progressView.isHidden = false
//                let progress = 1.0 * CGFloat( receivedSize / expectedSize)
//                self.progressView.setProgress(progress, animated: true)
//                self.topicModel.pictureProgress = progress
                }) { (image, error, cacheType, imageURL) in
//                    self.progressView.isHidden = true
//                    if !self.topicModel.hiddenSeebigButton {
//                    }
                    UIGraphicsBeginImageContextWithOptions(self.topicModel.pictureF.size, true, 0.0)
                    let imageW = self.pictureImageView.size.width
                    let imageH = self.topicModel.height * imageW / self.topicModel.width
                    image?.draw(in: CGRect(x: 0, y: 0, width: imageW, height: imageH))
                    self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
            }
            self.GifView.isHidden = !topicModel.is_gif
            if topicModel.hiddenSeebigButton {
                seeBigButton.isHidden = true
            }else {
                seeBigButton.isHidden = false
            }
        }
    }
    
    
}
