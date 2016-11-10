//
//  EssenseController.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class EssenseController: UIViewController {
    
    var titleView:TitleIndicatorView!
    
    var contentView:UIScrollView!
    
    var a:String! = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        a = "list"
        
        setupNavItem()
        
        setupTitleView()
        
        setupChildVcs()
        
        setupContentView()
    }


    func setupNavItem() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: "MainTagSubIcon", highlightedImage: "MainTagSubIconClick", target: self, action: #selector(EssenseController.essenseClick))
        view.backgroundColor = ConstTool.instance.GlobalColor()
    }
    
    func setupTitleView() {
        titleView = TitleIndicatorView.init(frame: CGRect(x: 0, y: ConstTool.instance.TitleViewY, width: view.width, height: ConstTool.instance.TitleViewHeight))
        titleView.delegate = self
        view.addSubview(titleView)
    }
    
    func essenseClick()  {
        let recommendTagsVC = RecommendTagsController()
        self.navigationController?.pushViewController(recommendTagsVC, animated: true)
    }
    
    func setupChildVcs()  {
        automaticallyAdjustsScrollViewInsets = false
        let all = TopViewController()
        all.type = 1
        all.a = a
        addChildViewController(all)
        let video = TopViewController()
        video.type = 41
        video.a = a
        addChildViewController(video)
        let voice = TopViewController()
        voice.type = 31
        voice.a = a
        addChildViewController(voice)
        let picture = TopViewController()
        picture.type = 10
        picture.a = a
        addChildViewController(picture)
        let words = TopViewController()
        words.type = 29
        words.a = a 
        addChildViewController(words)
        
        
    }
    
    func setupContentView() {
        automaticallyAdjustsScrollViewInsets = false
        let contentView = UIScrollView()
        contentView.delegate = self
        contentView.isPagingEnabled = true
        contentView.frame = view.bounds
        contentView.contentSize = CGSize(width: contentView.width * CGFloat(childViewControllers.count), height: 0)
        view .insertSubview(contentView, at: 0)
        
        scrollViewDidEndScrollingAnimation(contentView)
        self.contentView = contentView
    }
}

extension EssenseController:TitleIndicatorViewDelegate,UIScrollViewDelegate {

    func didClickItem(titleIndicatorView: TitleIndicatorView, button: UIButton) {
        UIView.animate(withDuration: 0.25) {
            button.isEnabled = false
            self.titleView.selectedButton.isEnabled = true
            self.titleView.selectedButton = button
            self.titleView.indicatorView.width = (button.titleLabel?.width)!
            self.titleView.indicatorView.centerX = button.centerX
        }
        var offset = self.contentView.contentOffset
        offset.x = self.contentView.width * CGFloat(button.tag)
        self.contentView.setContentOffset(offset, animated: true)
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.25) {
            
            if self.titleView.indicatorView != nil && self.titleView.selectedButton != nil {
                self.titleView.indicatorView.width = (self.titleView.selectedButton.titleLabel?.width)!
                self.titleView.indicatorView.centerX = self.titleView.selectedButton.centerX

            }
            
        }
        let index = scrollView.contentOffset.x / scrollView.width
        let vc = childViewControllers[Int(index)]
        
        vc.view.x = scrollView.contentOffset.x
        
        vc.view.y = 0
        
        vc.view.height = scrollView.height
        
        scrollView .addSubview(vc.view)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        let index = scrollView.contentOffset.x / scrollView.width
        didClickItem(titleIndicatorView: titleView, button: titleView.subviews[Int(index)] as! UIButton)
    }
}
