//
//  BaseNavigationController.m
//  OCTools
//
//  Created by 周 on 2018/10/30.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    //设置navigationBar颜色
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:App_Main_Color rect:CGRectMake(0, 0, UI_SCREEN_WIDTH, HeightForNagivationBarAndStatusBar)] forBarMetrics:UIBarMetricsDefault];
    //毛玻璃效果
    self.navigationBar.translucent = NO;
    //设置标题的样式
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
#pragma mark - 控制器视图将要出现时
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //通过对当前navigationController中viewControllers的数量来判断是否需要隐藏tabBar
    if (self.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
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
