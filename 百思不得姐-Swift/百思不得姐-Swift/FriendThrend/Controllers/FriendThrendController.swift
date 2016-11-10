//
//  FriendThrendController.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class FriendThrendController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = ConstTool.instance.GlobalColor()
        
        setupNavItem()
    }

    func setupNavItem() {
        view.backgroundColor = ConstTool.instance.GlobalColor()
        navigationItem.title = "我的关注"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: "friendsRecommentIcon", highlightedImage: "friendsRecommentIcon-click", target: self, action: #selector(FriendThrendController.friendClick))
    }
    
    func friendClick() {
        
        let recommendVc = RecommendViewController()
        
        self.navigationController?.pushViewController(recommendVc, animated: true)
        
    }
    
    @IBAction func RegisterBtnClick(_ sender: UIButton) {
        
        let loginVC = LoginViewController()

        present(loginVC, animated: true, completion: nil)
    }

}
