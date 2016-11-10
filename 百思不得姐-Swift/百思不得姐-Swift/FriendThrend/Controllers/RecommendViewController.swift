//
//  RecommendViewController.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {
    
    @IBOutlet weak var categoryView: UITableView!
    
    @IBOutlet weak var categoryListView: UITableView!
    
    lazy var viewModel:RecommendViewModel = {
    
        let vcm = RecommendViewModel()
        
        return vcm
    }()
    
    lazy var manager:RecommedManager = {
    
        let recommendManager = RecommedManager()
        
        return recommendManager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "推荐关注"
        view.backgroundColor = ConstTool.instance.GlobalColor()
        automaticallyAdjustsScrollViewInsets = false
        
        categoryView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        categoryListView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
     
        categoryView.delegate = self.manager
        categoryListView.delegate = self.manager
        
        categoryListView.dataSource = self.manager
        categoryView.dataSource = self.manager
        
        self.viewModel.categoryView = categoryView
        self.viewModel.categoryListView = categoryListView
        
        self.manager.viewModel = self.viewModel
        
        
        self.viewModel.getRecommendCategoryDataFromNet()
        
    }
    


}
