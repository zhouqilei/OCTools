//
//  BaseTabBarController.m
//  OCTools
//
//  Created by 周 on 2018/10/29.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaseTabBarController.h"
#import "CustomTabBar.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setValue:[CustomTabBar new] forKey:@"tabBar"];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
