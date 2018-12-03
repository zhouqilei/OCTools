//
//  AppDelegate.m
//  OCTools
//
//  Created by 周 on 2018/10/29.
//  Copyright © 2018年 周. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "Item1ViewController.h"
#import "Item2ViewController.h"
#import "GuidePageViewController.h"
#import "AdViewController.h"
@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置引导页
    /*
    GuidePageViewController *vc = [[GuidePageViewController alloc]init];
    vc.imageArrary = @[@"Intro_Screen_1",@"Intro_Screen_2",@"Intro_Screen_3",@"Intro_Screen_4"];
    //点击按钮后的方法回调
    vc.didClickStartBtnBlock = ^{
//        Item1ViewController *v1 = [[Item1ViewController alloc]init];
//        BaseNavigationController *n1 = [[BaseNavigationController alloc]initWithRootViewController:v1];
//        Item2ViewController *v2 = [[Item2ViewController alloc]init];
//        BaseNavigationController *n2 = [[BaseNavigationController alloc]initWithRootViewController:v2];
//
//        self.tabBarController = [[BaseTabBarController alloc]init];
//        self.tabBarController.viewControllers = @[n1,n2];
//
//        UITabBar *tabBar = self.tabBarController.tabBar;
//
//        UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
//        item1.title = @"item1";
//
//        UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
//        item2.title = @"item2";
//
//        self.window.rootViewController = self.tabBarController;
    };
    self.window.rootViewController = vc;
   */
    //设置广告启动图
    
//    AdViewController *vc = [[AdViewController alloc]init];
//    vc.url = @"http://img.zcool.cn/community/01316b5854df84a8012060c8033d89.gif";
//    vc.skipDidClickBlock = ^{
//        Item1ViewController *v1 = [[Item1ViewController alloc]init];
//        BaseNavigationController *n1 = [[BaseNavigationController alloc]initWithRootViewController:v1];
//        Item2ViewController *v2 = [[Item2ViewController alloc]init];
//        BaseNavigationController *n2 = [[BaseNavigationController alloc]initWithRootViewController:v2];
//
//        self.tabBarController = [[BaseTabBarController alloc]init];
//        self.tabBarController.viewControllers = @[n1,n2];
//
//        UITabBar *tabBar = self.tabBarController.tabBar;
//
//        UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
//        item1.title = @"item1";
//
//        UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
//        item2.title = @"item2";
//
//        self.window.rootViewController = self.tabBarController;
//    };
//    vc.adDidClickBlock = ^{
//        NSLog(@"点击了广告页面");
//    };
//    self.window.rootViewController = vc;
    if (IS_IPHONE_Xr) {
        NSLog(@"hahah");
    }
    //设置3DTouch
    [self set3DTouch];
    
    Item1ViewController *v1 = [[Item1ViewController alloc]init];
    BaseNavigationController *n1 = [[BaseNavigationController alloc]initWithRootViewController:v1];
    Item2ViewController *v2 = [[Item2ViewController alloc]init];
    BaseNavigationController *n2 = [[BaseNavigationController alloc]initWithRootViewController:v2];

    self.tabBarController = [[BaseTabBarController alloc]init];
    self.tabBarController.viewControllers = @[n1,n2];

    UITabBar *tabBar = self.tabBarController.tabBar;

    UITabBarItem *item1 = [tabBar.items objectAtIndex:0];
    item1.title = @"item1";

    UITabBarItem *item2 = [tabBar.items objectAtIndex:1];
    item2.title = @"item2";

    self.window.rootViewController = self.tabBarController;
    //设置nav
    [self setNavBar];
    //添加网络变化的监听
    self.coon = [Reachability reachabilityForInternetConnection];
    [self.coon startNotifier];
    /**配置高德地图*/
    //配置HTTPS可用
    [AMapServices sharedServices].enableHTTPS = YES;
    //配置高德地图key
    [AMapServices sharedServices].apiKey = @"095c30bf13a270682b60572d310048a8";
    /**配置百度地图 需引入头文件（<BaiduMapAPI_Map/BMKMapComponent.h>）*/
    BMKMapManager *manager = [[BMKMapManager alloc]init];
    BOOL ret = [manager start:@"QyyYNtdIRObLlCduZjBY7N2RkOOCcqPC" generalDelegate:self];
    if (!ret) {
        NSLog(@"百度地图开启失败");
    }
    return YES;
}
//设置navigationBar
- (void)setNavBar {
    //初始化
    [WRNavigationBar wr_widely];
    //设置黑名单，不使用的控制器
    [WRNavigationBar wr_setBlacklist:@[@"TZPhotoPickerController",
                                       @"TZGifPhotoPreviewController",
                                       @"TZAlbumPickerController",
                                       @"TZPhotoPreviewController",
                                       @"TZVideoPlayerController",
                                       @"SearchViewController"]];
    //设置默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:App_Main_Color];
    //设置按钮默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    //设置标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    //设置底部分割线隐藏
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}

- (void)set3DTouch{
    UIApplicationShortcutIcon *scan = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon-tj"];
    
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"1" localizedTitle:@"扫一扫" localizedSubtitle:@"" icon:scan userInfo:nil];
    //设置APP快捷菜单
    [[UIApplication sharedApplication] setShortcutItems:@[item1]];

}
#pragma mark - 点击快捷菜单实现方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.localizedTitle isEqualToString:@"扫一扫"]) {
        NSLog(@"点击了扫一扫");
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
