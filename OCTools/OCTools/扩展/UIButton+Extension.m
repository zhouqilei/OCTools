//
//  UIButton+Extension.m
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)
- (void)layoutButtonWithStyle:(ButtonEdgeInsetStyle)style imageTitleSpace:(CGFloat)space{
    CGFloat imageWidth = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    }else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    //声明图片与文字的边距
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    
    //根据style和space进行赋值
    switch (style) {
        case ButtonEdgeInsetStyleTop:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - space / 2.0, 0, 0, -labelWidth);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, -imageHeight - space / 2.0, 0);
            break;
        case ButtonEdgeInsetStyleLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            titleEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
            break;
        case ButtonEdgeInsetStyleBottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            titleEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWidth, 0, 0);
            break;
        case ButtonEdgeInsetStyleRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-space/2.0, 0, imageWidth+space/2.0);
            break;
        default:
            break;
    }
    //赋值
    self.titleEdgeInsets = titleEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
