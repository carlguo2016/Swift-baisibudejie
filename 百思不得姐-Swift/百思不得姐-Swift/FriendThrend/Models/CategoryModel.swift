//
//  CategoryModel.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {

    var ID:Int = 0
    
    var name:String?
    
    var count:Int = 0
    
    var listArray:NSMutableArray = {
    
        let list = NSMutableArray()
        
        return list
    }()
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID":"id"]
    }
    
    
    
    
}
