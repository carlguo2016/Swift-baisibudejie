//
//  NewViewController.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class NewViewController: EssenseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        a = "newlist"
        setupNavItem()
    }


    override func setupNavItem() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: "MainTagSubIcon", highlightedImage: "MainTagSubIconClick", target: self, action: #selector(NewViewController.MainClick))
        view.backgroundColor = ConstTool.instance.GlobalColor()
    }
    
    func MainClick() {
        
    }
    
}
