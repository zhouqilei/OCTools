//
//  SuspensionView.h
//  OCTools
//
//  Created by 周 on 2018/11/23.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspensionView : UIView
/**悬浮按钮*/
@property (nonatomic, strong)UIButton *suspensionBtn;
/**显示*/
- (void)show;
/**隐藏*/
- (void)hide;
@end

NS_ASSUME_NONNULL_END
