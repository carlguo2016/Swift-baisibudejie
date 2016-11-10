//
//  TopViewController.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/31.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit


class TopViewController:UITableViewController {
    
    lazy var viewModel:TopicViewModel = {
        
        let topicVm = TopicViewModel()
        
        return topicVm
    }()
    
    var type:NSInteger = 0
    var a:String! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.type = self.type
        viewModel.a = a 
        viewModel.tableView = tableView
        
        setupTableView()
        
        setupRefresh()
        
    }

    func setupTableView() {
        let bottom = tabBarController?.tabBar.height
        let top = ConstTool.instance.TitleViewHeight + ConstTool.instance.TitleViewY
        tableView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom!, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        let nib = UINib(nibName: "TopicCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "topic")
    }
    
    func setupRefresh() {
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(TopViewController.loadTopicModel))
        tableView.mj_header.isAutomaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshBackFooter.init(refreshingTarget: self, refreshingAction: #selector(TopViewController.loadMoreTopicModel))
        tableView.mj_footer.isAutomaticallyChangeAlpha = true
    }

    func loadTopicModel() {
        viewModel.topicArray.removeAllObjects()
        viewModel.page = 0
        viewModel.loadTopicDataFromNet()
    }
    
    func loadMoreTopicModel() {
        viewModel.page += 1
        tableView.mj_footer.beginRefreshing()
        viewModel.loadTopicDataFromNet()
    }
}

extension TopViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.topicArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "topic", for: indexPath) as! TopicCell
        
        cell.topicModel = viewModel.topicArray[indexPath.row] as! TopicModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let topicModel = viewModel.topicArray[indexPath.row] as! TopicModel
        
        return topicModel.cellHeight
    }
}
