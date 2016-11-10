//
//  RecommendTagsController.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/9.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class RecommendTagsController: UITableViewController {

    
    lazy var viewModel:RecommendTagsViewModel = {
        
        let recommendVm = RecommendTagsViewModel()
        
        return recommendVm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.tableView = tableView
        
        navigationItem.title = "推荐标签"
        let nib = UINib(nibName: "RecommendTagsCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "tagCell")
        tableView.backgroundColor = ConstTool.instance.GlobalColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        viewModel.getRecommendTagsDataFromNet()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tagsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as! RecommendTagsCell
        
        cell.tagModel = viewModel.tagsArray[indexPath.row] as! RecommendTagsModel
        
        return cell
        
    }
    
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }

}
