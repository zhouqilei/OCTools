//
//  AppDelegate.h
//  OCTools
//
//  Created by 周 on 2018/10/29.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BaseTabBarController *tabBarController;
@property (nonatomic, strong)Reachability *coon;
@end

