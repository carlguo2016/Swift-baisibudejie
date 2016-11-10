//
//  SquareView.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class SquareView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        var parameters = [String:Any]()
        
        parameters["a"] = "square"
        parameters["c"] = "topic"
        let manager = AFHTTPSessionManager()
        manager.get("http://api.budejie.com/api/api_open.php", parameters: parameters, progress: {(progress) in
        
        }, success: {(task, response) in
            let responseObj = response as! [String:Any]
        let squares = SquareModel.mj_objectArray(withKeyValuesArray: responseObj["square_list"])
            self.setupSquareButton(squares: squares!)
        }, failure: {(task, error) in
        
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSquareButton(squares:NSArray)  {
        let colms = 4
        let buttonW:CGFloat = ConstTool.instance.kScreenW / CGFloat(colms)
        let buttonH = buttonW
        for i in 0 ..< squares.count {
            let col = i % colms
            let row = i / colms
            let buttonX = CGFloat(col) * buttonW
            let buttonY = CGFloat(row) * buttonH
            let button = SquareButton(type: .custom)
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            addSubview(button)
            
            button.squareModel = squares[i] as! SquareModel
            
            button.addTarget(self, action: #selector(SquareView.buttonClick(button:)), for: .touchUpInside)
        }
        
        let rows = (squares.count + colms - 1) / colms
        self.height = CGFloat(rows) * buttonH
        let tableView:UITableView = self.superview as! UITableView
        tableView.tableFooterView = self
    }
    
    func buttonClick(button:SquareButton) {
        
        let url:NSString = NSString.init(string: button.squareModel.url!)
        
        if !url.hasPrefix("http") {
            return
        }
        let webVC = WebController()
        
        webVC.url = button.squareModel.url!
        webVC.title = button.squareModel.name
        
        let tabVc = UIApplication.shared.keyWindow?.rootViewController as! UITabBarController
        let navVc = tabVc.selectedViewController as! UINavigationController
        
        navVc.pushViewController(webVC, animated: true)
        
        
    }
}
