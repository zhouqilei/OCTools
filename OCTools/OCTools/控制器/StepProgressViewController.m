//
//  StepProgressViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/22.
//  Copyright © 2018年 周. All rights reserved.
//

#import "StepProgressViewController.h"
#import "StepProgressView.h"
@interface StepProgressViewController ()

@end

@implementation StepProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    StepProgressView *view = [[StepProgressView alloc]initWithFrame:CGRectMake(10, 10 + HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH - 20, 40) targetNum:5];
    [view setProgress:4];
    [self.view addSubview:view];
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
