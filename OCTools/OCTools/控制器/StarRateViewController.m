//
//  StarRateViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import "StarRateViewController.h"
#import "StarRateView.h"
@interface StarRateViewController ()<StarRateViewDelegate>

@end

@implementation StarRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    StarRateView *view = [[StarRateView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, 60) AndStarCount:5];
    view.rateStyle = IncompleteStar;
    view.delegate = self;
    view.currentRate = 2.1;
    [self.view addSubview:view];
}
#pragma mark - StarRateViewDelegate
- (void)starRateView:(StarRateView *)view didFinishRate:(CGFloat)rate {
    NSLog(@"%.2f",rate);
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
