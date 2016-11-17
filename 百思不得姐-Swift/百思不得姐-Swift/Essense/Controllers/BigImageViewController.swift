//
//  BigImageViewController.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/11.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class BigImageViewController: UIViewController {
    
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var imageView:UIImageView!
    
    var topicModel:TopicModel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupLargeImageShow()
    }

    func setupLargeImageShow() {
    
        let imageView = UIImageView()
        imageScrollView.addSubview(imageView)
        self.imageView = imageView
        
        let imageH:CGFloat = topicModel.height * ConstTool.instance.kScreenW / topicModel.width
        if imageH > ConstTool.instance.kScreenH {
            imageView.frame = CGRect(x: 0, y: 0, width: ConstTool.instance.kScreenW, height: imageH)
            imageScrollView.contentSize = CGSize(width: 0, height: imageH)
        }else {
            imageView.size = CGSize(width: ConstTool.instance.kScreenW, height: imageH)
            imageView.center = imageScrollView.center
        }
        
        imageView.sd_setImageWithPreviousCachedImage(with: URL(string:topicModel.large_image!), placeholderImage: nil, options: SDWebImageOptions.init(rawValue: 0), progress:nil, completed:nil)
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(BigImageViewController.back(_:))))
        
    }
    
    
    @IBAction func share(_ sender: Any) {
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func save(_ sender: Any) {
        if imageView.image == nil{
            SVProgressHUD.showError(withStatus: "图片未下载完毕!")
            return
        }
//        UIImageWriteToSavedPhotosAlbum(imageView.image!, self,#selector(BigImageViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
    }

  @objc private func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:UnsafeRawPointer) {
        if error != nil {
            SVProgressHUD.showError(withStatus:"保存失败")
        }else {
        
            SVProgressHUD.showSuccess(withStatus: "保存成功")
        }
    }
   
}
