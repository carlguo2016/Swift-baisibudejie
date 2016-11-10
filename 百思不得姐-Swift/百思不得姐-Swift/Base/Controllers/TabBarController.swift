//
//  TabBarController.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupItem()
        
        setupChildVcs()
        
        setupTabBar()

    }

    
    
    private func setupItem() {
    
        var normalAttrs = [String:Any]()
        
        normalAttrs[NSForegroundColorAttributeName] = UIColor.gray
        
        normalAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 12)
        
        var selectedAttrs = [String:Any]()
        
        selectedAttrs[NSForegroundColorAttributeName] = UIColor.darkGray
        
        let item = UITabBarItem.appearance()
        
        item.setTitleTextAttributes(normalAttrs, for: .normal)
        
        item.setTitleTextAttributes(selectedAttrs, for: .selected)
        
    }
    
    private func setupChildVcs() {
    
        setupChildVc(vc: EssenseController(),title:"精华",image:"tabBar_essence_icon",selectedImage:"tabBar_essence_click_icon")
        setupChildVc(vc: NewViewController(),title:"新帖",image:"tabBar_new_icon",selectedImage:"tabBar_new_click_icon")
        setupChildVc(vc: FriendThrendController(),title:"关注",image:"tabBar_friendTrends_icon",selectedImage:"tabBar_friendTrends_click_icon")
        setupChildVc(vc: ProfileController(),title:"我",image:"tabBar_me_icon",selectedImage:"tabBar_me_click_icon")

    }
    
    
    private func setupTabBar() {
        setValue(TabBar(), forKeyPath: "tabBar");
        
    }
    
    private func setupChildVc(vc:UIViewController,title:String,image:String,selectedImage:String) {
    
        let nav = NavigationController(rootViewController: vc)
        
        addChildViewController(nav)
        
        nav.tabBarItem.title = title
        
        nav.tabBarItem.image = UIImage(named: image)
        
        nav.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        
    }
}
