//
//  UIButton+Extension.h
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ButtonEdgeInsetStyle){
    /**图上字下*/
    ButtonEdgeInsetStyleTop,
    /**图左字右*/
    ButtonEdgeInsetStyleLeft,
    /**图下字上*/
    ButtonEdgeInsetStyleBottom,
    /**图右字左*/
    ButtonEdgeInsetStyleRight
};
@interface UIButton (Extension)
/**图文按钮布局*/
- (void)layoutButtonWithStyle:(ButtonEdgeInsetStyle)style imageTitleSpace:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
