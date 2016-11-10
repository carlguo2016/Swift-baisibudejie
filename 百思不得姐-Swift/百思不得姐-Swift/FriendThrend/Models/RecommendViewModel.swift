//
//  RecommendViewModel.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class RecommendViewModel: NSObject {

    
    lazy var categoryListArray:NSMutableArray = {
    
        let array = NSMutableArray()
        
        return array
    }()
    
    lazy var categoryArray:NSMutableArray = {
    
        let array = NSMutableArray()
        
        return array
    }()
    
    var page:Int = 0
    
    var categoryId:Int = 0
    
    var refresh:Bool = false

    var categoryView:UITableView! {
        
        didSet {
            
            let nib  = UINib(nibName: "CategoryCell", bundle: nil)
            
            categoryView.register(nib, forCellReuseIdentifier: "categoryCell")
        }
    }
    
    var categoryListView:UITableView! {
        
        didSet {
            
            let nib = UINib(nibName: "CategoryListCell", bundle: nil)
            
            categoryListView.register(nib, forCellReuseIdentifier: "categoryListCell")
            
            page = 1
            
            setupRefresh()
        }
    }

    func setupRefresh() {
        categoryListView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(RecommendViewModel.loadNewData))
    
    
        categoryListView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(RecommendViewModel.loadMoreData))
    }
    
    func loadNewData()  {
     
        page = 1
        refresh = true
        getCategoryListArray()
    }
    
    func loadMoreData() {
        page += 1
        refresh = false
        getCategoryListArray()
    }
    
    func getCategoryListArray() {
        
        var parameters = [String:Any]()
        
        parameters["a"] = "list"
        parameters["c"] = "subscribe"
        parameters["category_id"] = categoryId
        parameters["page"] = page
        let manager = AFHTTPSessionManager()
        manager.get("http://api.budejie.com/api/api_open.php", parameters: parameters, progress: { (progress) in
        
        }, success: { (task, responseObj) in
        
            let response = responseObj as! [String:Any]
            if self.refresh && (response["list"] as! NSArray).count > 0 {
            
                self.categoryListArray.removeAllObjects()
            }
            
            let array = CategoryListModel.mj_objectArray(withKeyValuesArray: response["list"])
            
            for model in array! {
            
                self.categoryListArray.add(model)
            }
            self.categoryListView.reloadData()
            
            if self.categoryListArray.count == response["total"] as! Int {
            
                self.categoryListView.mj_footer.endRefreshingWithNoMoreData()
            }else {
            
                self.categoryListView.mj_footer.endRefreshing()
            }
            
            self.categoryListView.mj_header.endRefreshing()
        
        }, failure: { (task , error) in
        
            self.categoryListView.mj_header.endRefreshing()
            self.categoryListView.mj_footer.endRefreshing()
        
        })
        
        
    }
    
    func getRecommendCategoryListDataFromNetWithCategoryId(ID:Int) {
        if categoryId != ID {
            categoryListArray.removeAllObjects()
            categoryListView.reloadData()
        }
        
        categoryId = ID
        categoryListView.mj_header.beginRefreshing()
        getCategoryListArray()
    }
    
    func getRecommendCategoryDataFromNet() {
        
        SVProgressHUD.show()
        
        var parameters = [String:Any]()
        
        parameters["a"] = "category"
        parameters["c"] = "subscribe"
        let manager = AFHTTPSessionManager()
        
         manager.get("http://api.budejie.com/api/api_open.php", parameters: parameters, progress: {(progress) in
        
        }, success: { (task, responseObj)  in
        SVProgressHUD.dismiss()
            if responseObj != nil {
                
                let response = responseObj as! [String:Any]
                
                self.categoryArray = CategoryModel.mj_objectArray(withKeyValuesArray: response["list"])
                
                self.categoryView.reloadData()
                
                let indexPath = NSIndexPath(row: 0, section: 0)
                
                self.categoryView.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .top)
                let model = self.categoryArray[0] as! CategoryModel
                
                self.getRecommendCategoryListDataFromNetWithCategoryId(ID: model.ID)
                
            }
            
        }, failure: {(task, error )  in
        
            SVProgressHUD.showError(withStatus: "分类数据加载失败")
        })
        
    }
    
    
}
