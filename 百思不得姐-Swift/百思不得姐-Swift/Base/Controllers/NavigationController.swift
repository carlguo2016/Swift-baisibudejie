//
//  NavigationController.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        let bar = UINavigationBar.appearance()
        bar.setBackgroundImage(UIImage(named:"navigationbarBackgroundWhite"), for: .default)
        
        var barAttrs = [String:Any]()
        
        barAttrs[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 20)
        bar.titleTextAttributes = barAttrs
        
        let item = UIBarButtonItem.appearance()
        
        var normalAttrs = [String:Any]()
        
        normalAttrs[NSForegroundColorAttributeName] = UIColor.black
        
        normalAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 17)
        item.setTitleTextAttributes(normalAttrs, for: .normal)
        
        var selectedAttrs = [String:Any]()
        
        selectedAttrs[NSForegroundColorAttributeName] = UIColor.lightGray
        item.setTitleTextAttributes(selectedAttrs, for: .selected)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            let back = UIButton(type: .custom)
            back.setTitle("返回", for: .normal)
            back.setTitleColor(UIColor.black, for: .normal)
            back.setTitleColor(UIColor.red, for: .highlighted)
            back.setImage(UIImage(named:"navigationButtonReturn"), for: .normal)
            back.setImage(UIImage(named:"navigationButtonReturnClick"), for: .highlighted)
            back.sizeToFit()
            back.addTarget(self, action: #selector(NavigationController.backClick), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: back)
            viewController.hidesBottomBarWhenPushed = true
            
        }
        super.pushViewController(viewController, animated: animated)
    }
    
   @objc func backClick() {
        popViewController(animated: true)
    }


}
