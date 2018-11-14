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
@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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
