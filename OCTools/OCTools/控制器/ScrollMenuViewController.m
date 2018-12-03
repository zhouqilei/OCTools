//
//  ScrollMenuViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import "ScrollMenuViewController.h"
#import "ScrollMenuView.h"
@interface ScrollMenuViewController ()<ScrollMenuViewDelegate>

@end

@implementation ScrollMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ScrollMenuView *menu = [[ScrollMenuView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, 44) andStyle:ScrollMenuViewStyleValue2];
    menu.items = @[@"热门",@"视频",@"财经频道"];
    menu.delegate = self;
    [self.view addSubview:menu];
}
#pragma mark - ScrollMenuViewDelegate
- (void)scrollMenuView:(ScrollMenuView *)view didClickItemAtIndex:(NSInteger)index {
    NSLog(@"%ld",(long)index);
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
