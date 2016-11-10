//
//  UIBarButtonItem+Extension.h
//  百思不得姐-Swift
//
//  Created by Geb on 2016/10/31.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
