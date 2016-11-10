//
//  NetWorkTool.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/31.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class NetWorkTool: AFHTTPSessionManager {

    static let sharedTool:NetWorkTool = {
    
        let instance = NetWorkTool()
        instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json","text/json","text/javascript","text/plain","text/html") as? Set<String>
        return instance
    }()
    
    class func NetWorkToolGet(urlString:String,parameters:Any,success:(( _ response:[String:Any]?) ->Void)?,failure:((_ error:NSError) -> Void)?) {
        
        NetWorkTool.sharedTool.get(urlString, parameters: parameters, progress: { (progress) in
            
            }, success: { (task, responseObj) in
                if responseObj != nil {
                    success!(responseObj! as? [String:Any])
                }
            }) { (task, error) in
               failure!(error as NSError)
        }
        
    }
    
}
