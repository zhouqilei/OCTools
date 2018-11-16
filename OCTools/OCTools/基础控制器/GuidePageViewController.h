//
//  GuidePageViewController.h
//  OCTools
//
//  Created by 周 on 2018/11/16.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^didClickStartBtn)(void);
@interface GuidePageViewController : UIViewController
/**引导页图片数组*/
@property (nonatomic, strong)NSArray *imageArrary;
/**点击了开始按钮的回调*/
@property (nonatomic, copy)didClickStartBtn didClickStartBtnBlock;
@end

NS_ASSUME_NONNULL_END
