//
//  RecommedManager.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class RecommedManager: NSObject {

   weak var viewModel:RecommendViewModel!
    
    
}


extension RecommedManager:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if tableView.tag == 1 {
            
            return viewModel.categoryArray.count
        }
        tableView.mj_footer.isHidden = (viewModel.categoryListArray.count == 0)
        return viewModel.categoryListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
            cell.categoryModel = viewModel.categoryArray[indexPath.row] as! CategoryModel
            
            return cell
        }
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "categoryListCell", for: indexPath) as! CategoryListCell
        cell.categoryListModel = viewModel.categoryListArray[indexPath.row] as! CategoryListModel
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.tag == 2 {
            return 80
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1 {
            viewModel.categoryListView.mj_footer.endRefreshing()
            let model = viewModel.categoryArray[indexPath.row] as! CategoryModel
            viewModel.page = 1
            viewModel.getRecommendCategoryListDataFromNetWithCategoryId(ID: model.ID)
            
        }
    }
    
    
}
