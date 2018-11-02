//
//  UpView.h
//  OCTools
//
//  Created by 周 on 2018/11/1.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UpView : UIView
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, assign)CGFloat contentHeight;
//弹出
- (void)show;
//隐藏
- (void)dismiss;
//设置视图
- (void)setUpView;
@end

NS_ASSUME_NONNULL_END
