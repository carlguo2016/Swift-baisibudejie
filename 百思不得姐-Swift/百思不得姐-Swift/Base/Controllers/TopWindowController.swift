//
//  TopWindowController.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/31.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class TopWindowController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.clear
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let windows = UIApplication.shared.windows
        for window in windows {
            searchSubViews(window:window)
        }
    }
    
    private func searchSubViews(window:UIView) {
        for scrollView in window.subviews {
            searchSubViews(window: scrollView)
            if !scrollView.isKind(of: UIScrollView.classForCoder()) {
                continue
            }
            let scrollViewRect = scrollView.convert(scrollView.bounds, from: scrollView.window)
            let windowRect = scrollView.window?.bounds
            if scrollViewRect.intersects(windowRect!) {
                continue
            }
            var offset = (scrollView as! UIScrollView).contentOffset
            offset.y = -(scrollView as! UIScrollView).contentInset.top
            (scrollView as! UIScrollView).setContentOffset(offset, animated: true)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
    
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
    
        return .default
    }

}
