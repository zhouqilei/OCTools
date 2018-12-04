//
//  AddToCarViewController.m
//  OCTools
//
//  Created by 周 on 2018/12/4.
//  Copyright © 2018年 周. All rights reserved.
//

#import "AddToCarViewController.h"

@interface AddToCarViewController ()
@property (nonatomic, strong)UIButton *addBtn;
@property (nonatomic, strong)UIButton *carBtn;
@end

@implementation AddToCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.addBtn = [[UIButton alloc]initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 60, UI_SCREEN_HEIGHT / 2, 20, 20)];
    self.addBtn.layer.cornerRadius = 10;
    self.addBtn.layer.masksToBounds = YES;
    [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addBtn.backgroundColor = [UIColor purpleColor];
    [self.addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addBtn];
    
    self.carBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - 60, 120, 60)];
    self.carBtn.backgroundColor = [UIColor purpleColor];
    [self.carBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.carBtn setTitle:@"购物车" forState:UIControlStateNormal];
    [self.view addSubview:self.carBtn];
}
//添加
- (void)addAction {
    UIView *tempView = [[UIView alloc]initWithFrame:self.addBtn.frame];
    tempView.backgroundColor = [UIColor redColor];
    [self.view addSubview:tempView];
    
    [tempView animationStartPoint:tempView.center endPoint:self.carBtn.center didStopAnimation:^{
        [tempView removeFromSuperview];
    }];
    
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
