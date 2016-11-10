//
//  ProfileController.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class ProfileController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavItem()
        
        setupTableView()
    }


    func setupNavItem() {
        navigationItem.title = "我的"
        let settingItem = UIBarButtonItem(image: "mine-setting-icon", highlightedImage: "mine-setting-icon-click", target: self, action: #selector(ProfileController.settingClick))
        let moonItem = UIBarButtonItem(image: "mine-moon-icon", highlightedImage: "mine-moon-icon-click", target: self, action: #selector(ProfileController.moonItemClick))
        navigationItem.rightBarButtonItems = [settingItem!,moonItem!]
        
        view.backgroundColor = ConstTool.instance.GlobalColor()
    }
    
    func settingClick() {
        
    }
    
    func moonItemClick() {
        
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(ProfileCell.classForCoder(), forCellReuseIdentifier: "profilecell")
        tableView.tableFooterView = SquareView()
        tableView.sectionFooterHeight = ConstTool.instance.TopicMargin
        tableView.sectionHeaderHeight = 0
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "profilecell", for: indexPath)
        if indexPath.section == 0 {
            cell.imageView?.image = UIImage(named: "setup-head-default")
            cell.textLabel?.text = "登录/注册"
        }else if (indexPath.section == 1){
        cell.textLabel?.text = "离线下载"
        }
        return cell
        
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
}
