//
//  RecommendTagsViewModel.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/9.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class RecommendTagsViewModel: NSObject {

  weak  var tableView:UITableView!
    
   lazy var tagsArray:NSMutableArray = {
    
        let tags = NSMutableArray()
    
        return tags
    }()
    
    var page:Int = 0
    
    var tagId:String?
    
   lazy var hotComArr:NSMutableArray = {
    
        let array = NSMutableArray()
        
        return array
    }()
    
   lazy var lastestComArr:NSMutableArray = {
    
        let array = NSMutableArray()
        
        return array
    }()
    
    
    func getRecommendTagsDataFromNet() {
       
        var parameters = [String:Any]()
        
        parameters["a"] = "tag_recommend"
        parameters["action"] = "sub"
        parameters["c"] = "topic"
        
        let manager = AFHTTPSessionManager()
        
        manager.get("http://api.budejie.com/api/api_open.php", parameters: parameters, progress: {(progress) in
        
        }, success: {(task, responseObj) in
            if responseObj == nil {
                
                return;
            }
            
            var array = [Any]()
            for recommendTagsModel in RecommendTagsModel.mj_objectArray(withKeyValuesArray: responseObj!) {
                array.append(recommendTagsModel)
            }
            
            self.tagsArray.addObjects(from: array)
            self.tableView.reloadData()
            if self.tableView.mj_header != nil {
                self.tableView.mj_header.endRefreshing()

            }
            
            if self.tableView.mj_footer != nil {
                self.tableView.mj_footer.endRefreshing()

            }

        
        }, failure: {(task, error) in
        
        })
        
        
    }
    
    func getCommentDataFromNet() {
        let pageNumber = page + 1
        var parameters = [String:Any]()
        parameters["a"] = "dataList"
        parameters["c"] = "comment"
        parameters["data_id"] = tagId!
        parameters["hot"] = "1"
        if pageNumber > 1 {
            let model = lastestComArr.lastObject as! CommentModel
            parameters["lastcid"] = model.ID!
        }
        parameters["page"] = pageNumber
        
        
        let manager = AFHTTPSessionManager()
        
        manager.get("http://api.budejie.com/api/api_open.php", parameters: parameters, progress: {(progress) in
        
        }, success: {(task, response) in
            var hotArr = [Any]()
            
            let responseObj = response as! [String:Any]
            
            for hotModel in CommentModel.mj_objectArray(withKeyValuesArray: responseObj["hot"]) {
                hotArr.append(hotModel)
            }
            
            self.hotComArr.addObjects(from: hotArr)
            
            var lastestArray = [Any]()
            for lastestModel in CommentModel.mj_objectArray(withKeyValuesArray: responseObj["data"]) {
                lastestArray.append(lastestModel)
            }
            
            self.lastestComArr.addObjects(from: lastestArray)
            self.tableView.reloadData()
            self.page = pageNumber
            let count = responseObj["total"] as! Int
            
            if (self.lastestComArr.count >= count) {
                self.tableView.mj_footer.endRefreshingWithNoMoreData();
            }else {
                self.tableView.mj_footer.endRefreshing();
            }
            self.tableView.mj_header.endRefreshing()
        
        }, failure: {(task, error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()

        })
    
    }
}
