//
//  TopicModel.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/31.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit


class UserModel: NSObject {
    
    var username:String?
    
    var sex:String?
    
    var profile_image:String?
}

class CommentModel:NSObject {
    var ID:String?
    
    var content:String?
    
    var user:UserModel?
    
    var voicetime:Int = 0
    
    var voiceurl:String?
    
    var like_count:Int = 0
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        
        return ["ID":"id"]
    }
}

extension  TopicModel {

    func isThisYear(date:Date) -> Bool {
        let calendar = Calendar.current
        let selfYear = calendar.component(.year, from: date)
        let nowYear = calendar.component(.year, from: Date())
        return selfYear == nowYear
    }
}

class TopicModel: NSObject {

    var ID:String!
    
    var name:String?
    
    var profile_image:String?
    
    var create_time:String?  {
    
        didSet {
            let fmt = DateFormatter()
            fmt.dateFormat = "yyy-MM-dd HH:mm:ss"
            let createDate = fmt.date(from: create_time!)
            if ConstTool.instance.isThisYear(date: createDate!) {
                let cmps = ConstTool.instance.deltaFrom(date: createDate!)
                if cmps.hour! >= 1 {
                  create_time = String(format: "%ld小时前", cmps.hour!)
                }else if(cmps.minute! >= 1) {
                    create_time = String(format: "%ld分钟前", cmps.minute!)
                }else {
                
                    create_time = "刚刚"
                }
                
            }else if (ConstTool.instance.isYesterday(date: createDate!)) {
            
                fmt.dateFormat = "昨天 HH:mm:ss"
                create_time = fmt.string(from: createDate!)
            }else {
            
                fmt.dateFormat = "MM-dd HH:mm:ss"
                create_time = fmt.string(from: createDate!)
            }
            
        }
    }
    
    var top_cmt:CommentModel?

    
    var ding:Int = 0
    
    var cai:Int = 0
    
    var repost:Int = 0
    
    var comment:Int = 0
    
    var maxtime:String?
    
    var sina_v:Bool = false
    
    var small_image:String?
    
    var large_image:String?
    
    var height:CGFloat = 0.0
    
    var width:CGFloat = 0.0
    
    var voicetime:Int = 0
    
    var plycount:Int = 0
    
    var voiceuri:String?
    
    var videotime:Int = 0
    
    var cdn_img:String?
    
    var videouri:String?
    
    var image_small:String?
    
    var is_gif:Bool = false
    
    var type: NSInteger = 0
    
    var cellHeight:CGFloat = 0.0
    
    var pictureF:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var hiddenSeebigButton:Bool = false
    
    var pictureProgress:CGFloat = 0
    
    var voiceF:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var videoF:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var text:String? {
        
        didSet {
            if cellHeight == 0.0 {
                cellHeight = ConstTool.instance.TopicTextY
                let maxSize = CGSize(width: ConstTool.instance.kScreenW - 4 * ConstTool.instance.TopicMargin, height: CGFloat(MAXFLOAT))
                let textStr = NSString(string: text!)
                let textH = textStr.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 14)], context: nil).size.height
                cellHeight += textH + ConstTool.instance.TopicMargin
                
                let contentW = maxSize.width
                var contentH = contentW * height / width
                let contentX = ConstTool.instance.TopicMargin
                let contentY = cellHeight
                if type == 10 {
                    if contentH > ConstTool.instance.TopicPictureMaxH {
                        contentH = ConstTool.instance.TopicPictureDefaultH
                        hiddenSeebigButton = true
                    }else {
                        hiddenSeebigButton = false
                    }
                    pictureF = CGRect(x: contentX, y: contentY, width: contentW, height: contentH)
                    cellHeight += contentH + ConstTool.instance.TopicMargin
                }else if (type == 31) {
                    
                    voiceF = CGRect(x: contentX, y: contentY, width: contentW, height: contentH)
                    cellHeight += contentH + ConstTool.instance.TopicMargin
                }else if(type == 41) {
                    
                    videoF = CGRect(x: contentX, y: contentY, width: contentW, height: contentH)
                    cellHeight += contentH + ConstTool.instance.TopicMargin
                }
                
                if top_cmt != nil {
                    let commentContent = NSString(format: "%@:%@", (top_cmt?.user?.username)!,(top_cmt?.content)!)
                    
                    let commentContentH = commentContent.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 13)], context: nil).size.height
                    cellHeight += commentContentH + ConstTool.instance.TopicMargin
                }
                
                cellHeight += ConstTool.instance.TopicBottomH + ConstTool.instance.TopicMargin
            }
            
        }
        
    }

    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["small_image":"image0","middle_image":"image2","large_image":"image1","ID":"id","top_cmt":"top_cmt[0]"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["top_cmt":CommentModel.classForCoder()]
    }
        
}
