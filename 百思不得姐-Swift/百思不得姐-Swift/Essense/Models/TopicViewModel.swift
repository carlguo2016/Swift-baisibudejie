//
//  TopicViewModel.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/31.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class TopicViewModel: NSObject {

    var a:String! = nil
    
    var type:NSInteger = 0
    
    var page:Int = 0
    
    var tableView:UITableView!
    
    var maxtime:String?
        
   lazy var topicArray:NSMutableArray = {
    
    let array = NSMutableArray()
    
    return array
    
    }()
    
    var parameters:NSDictionary?
    
    
    
    func loadTopicDataFromNet() {
     
        var parameters = [String:Any]()
        
        parameters["a"] = a
        
        parameters["c"] = "data"
        
        parameters["type"] = type
        
        parameters["page"] = page
        
        if maxtime != nil && (maxtime?.characters.count)! > 0  {
            parameters["maxtime"] = maxtime
        }
        self.parameters = parameters as NSDictionary?
        
        NetWorkTool.NetWorkToolGet(urlString: "http://api.budejie.com/api/api_open.php", parameters: parameters, success: { (responseObj) in
            
            if self.parameters != (parameters as NSDictionary?) {
                return
            }
            self.maxtime = (responseObj?["info"] as! [String:Any])["maxtime"] as! String?
            
            var array = [Any]()
            for topicModel in TopicModel.mj_objectArray(withKeyValuesArray: responseObj!["list"]) {
            array.append(topicModel)
            }
            
            self.topicArray.addObjects(from: array)
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            }) { (error) in
                if self.parameters != (parameters as NSDictionary?) {
                    return
                }
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                if self.page > 0 {
                
                    self.page -= 1
                }
        }
        
    }
    
}
