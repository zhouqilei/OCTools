//
//  UIView+Extension.h
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)
/**获取视图所在的控制器*/
@property (nonatomic, strong)UIViewController *viewController;
/**为视图添加点击方法*/
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end

NS_ASSUME_NONNULL_END
