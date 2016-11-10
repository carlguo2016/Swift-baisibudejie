//
//  ConstTool.swift
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/28.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class ConstTool: NSObject {
    
    internal static let instance = ConstTool()
    
    private override init() {
    
    }
    
    
    
    func Color(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    func GlobalColor() -> UIColor {
        return Color(r: 245.0, g: 245.0, b: 245.0, a: 1.0)
    }
    
    func ColorFromHedRGB(colorString:String) -> UIColor {
        var color = UIColor.red
        
        
        var string = colorString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if string.hasPrefix("#") {
            let index = string.index(after: string.startIndex)
            string = string.substring(from: index)
        }
        
        if string.characters.count != 6 {
            return UIColor.black
        }
        
        let rRange = string.startIndex ..< string.index(string.startIndex, offsetBy: 2)
        
        let rStr = string.substring(with: rRange)
        
        let gRange = string.index(string.startIndex, offsetBy: 2) ..< string.index(string.startIndex, offsetBy: 4)
        let gStr = string.substring(with: gRange)
        
        let bIndex = string.index(string.endIndex, offsetBy: -2)
        
        let bStr = string.substring(from:bIndex)
        
        
        var r:CUnsignedInt = 0,g:CUnsignedInt = 0,b:CUnsignedInt = 0;
        Scanner(string: rStr).scanHexInt32(&r)
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
        
        color = UIColor.init(colorLiteralRed: Float(r) / 255.0, green: Float(g) / 255.0, blue: Float(b) / 255.0, alpha: 1.0)
        
        //    color = UIColor.init(colorLiteralRed: Float(changeToInt(numStr: rStr)) / 255.0, green: Float(changeToInt(numStr: gStr)) / 255.0, blue: Float(changeToInt(numStr: bStr)) / 255.0, alpha: 1.0)
        return color

    }
    
    
    func imageWithColor(color:UIColor,size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let currentContext = UIGraphicsGetCurrentContext()
        let fillRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        currentContext!.setFillColor(color.cgColor)
        currentContext?.fill(fillRect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage!
    }
    
    func isThisYear(date:Date) -> Bool {
        let calendar = Calendar.current
        let selfYear = calendar.component(.year, from: date)
        let nowYear = calendar.component(.year, from: Date())
        return selfYear == nowYear
    }
    
    func isToday(date:Date) -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let nowString = fmt.string(from: date)
        let selfString = fmt.string(from: Date())
        return nowString == selfString
    }
    
    func isYesterday(date:Date) -> Bool {
        let fmt = DateFormatter()
        let nowDate = fmt.date(from: fmt.string(from: Date()))
        let selfDate = fmt.date(from: fmt.string(from: date))
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.year,.month,.day], from: selfDate!, to: nowDate!)
        
        return (cmps.year == 0 && cmps.month == 0 && cmps.day == 1)
        
    }
    
    func deltaFrom(date:Date) -> DateComponents {
        let calendar = Calendar.current
        let cmps = calendar.dateComponents([.year,.month,.day,.hour,.minute,.day], from: date, to: Date())
        
        return cmps
    }
    
    func circleImage(oldImage:UIImage!) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(oldImage.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height)
        ctx?.addEllipse(in: rect)
        ctx?.clip()
        oldImage.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    let kScreenW = UIScreen.main.bounds.width
    
    let kScreenH = UIScreen.main.bounds.height
    
    let TitleViewHeight:CGFloat = 35
    
    let TitleViewY:CGFloat = 64
    
    let TopicMargin:CGFloat = 10
    
    let TopicTextY:CGFloat = 55
    
    let TopicBottomH:CGFloat = 35
    
    let TopicPictureMaxH:CGFloat = 1000
    
    let TopicPictureDefaultH:CGFloat = 250
    
    let Male = "m"
    
    let Fmale = "f"
    
    let Top_CmtTitleH:CGFloat = 20
    
    let GGDidSelectViewControllerKey = "GGDidSelectViewControllerKey"
    

    
}
