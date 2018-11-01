//
//  BaseViewController.m
//  OCTools
//
//  Created by 周 on 2018/10/30.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //判断是否有上级页面来确定是否显示返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        [self setLeftBarButton];
    }
}
#pragma mark - 自定义返回按钮
- (void)setLeftBarButton{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon-fh"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
}
#pragma mark - 返回按钮点击事件
- (void)leftBarButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
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
