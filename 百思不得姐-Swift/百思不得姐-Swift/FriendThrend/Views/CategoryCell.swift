//
//  CategoryCell.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var indicatorView: UIView!
    
    
    var categoryModel:CategoryModel! {
    
        didSet {
        
            textLabel?.text = categoryModel.name
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = ConstTool.instance.Color(r: 244, g: 244, b: 244, a: 1)
        indicatorView.backgroundColor = ConstTool.instance.Color(r: 219, g: 21, b: 26, a: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.y = 2
        
        textLabel?.height = self.height - 2 * (textLabel?.y)!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        indicatorView.isHidden = !selected
        textLabel?.textColor = selected ? ConstTool.instance.Color(r: 219, g: 21, b: 26, a: 1) : ConstTool.instance.Color(r: 78, g: 78, b: 78, a: 1)
        
    }
    
}
