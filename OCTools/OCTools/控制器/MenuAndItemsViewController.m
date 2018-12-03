//
//  MenuAndItemsViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/8.
//  Copyright © 2018年 周. All rights reserved.
//

#import "MenuAndItemsViewController.h"
#import "MenuAndItemsView.h"
@interface MenuAndItemsViewController ()<MenuAndItemsViewDelegate>

@end

@implementation MenuAndItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *menuArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    NSArray *itemsArray = @[
  @{@"1":@[@"1.1",@"1.2",@"1.3",@"1.4",@"1.5",@"1.6",@"1.7",@"1.8"]},
  @{@"2":@[@"2.1",@"2.2",@"2.3",@"2.4",@"2.5",@"2.6",@"2.7",@"2.8"]},
  @{@"3":@[@"3.1",@"3.2",@"3.3",@"3.4",@"3.5",@"3.6",@"3.7",@"3.8"]},
  @{@"4":@[@"4.1",@"4.2",@"4.3",@"4.4",@"4.5",@"4.6",@"4.7",@"4.8"]},
  @{@"5":@[@"5.1",@"5.2",@"5.3",@"5.4",@"5.5",@"5.6",@"5.7",@"5.8"]},
  @{@"6":@[@"6.1",@"6.2",@"6.3",@"6.4",@"6.5",@"6.6",@"6.7",@"6.8"]},
  @{@"7":@[@"7.1",@"7.2",@"7.3",@"7.4",@"7.5",@"7.6",@"7.7",@"7.8"]},
  @{@"8":@[@"8.1",@"8.2",@"8.3",@"8.4",@"8.5",@"8.6",@"8.7",@"8.8"]}
  ];
    MenuAndItemsView *view = [[MenuAndItemsView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT) andMenu:menuArray items:itemsArray];
    view.delegate = self;
    [self.view addSubview:view];
}
#pragma makr - MenuAndItemsViewDelegate
- (void)menuAndItemsView:(MenuAndItemsView *)view didClickMenuAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
}
- (void)menuAndItemsView:(MenuAndItemsView *)view didClickItemAtIndexPaht:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
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
