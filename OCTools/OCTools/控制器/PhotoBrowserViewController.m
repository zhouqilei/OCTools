//
//  PhotoBrowserViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/22.
//  Copyright © 2018年 周. All rights reserved.
//

#import "PhotoBrowserViewController.h"
#import "YBImageBrowser.h"
@interface PhotoBrowserViewController ()
@property (nonatomic, strong)UIImageView *imageV;
@end

@implementation PhotoBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, 100, 100)];
    self.imageV.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV.image = [UIImage imageNamed:@"Intro_Screen_1"];
    [self.imageV addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.imageV];
}
- (void)clickImage{
    YBImageBrowseCellData *data = [YBImageBrowseCellData new];
    data.sourceObject = self.imageV;
    data.imageBlock = ^__kindof UIImage * _Nullable{
        return [UIImage imageNamed:@"Intro_Screen_1"];
    };
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.transitionDuration = 0.3;
    browser.dataSourceArray = @[data];
    [browser show];
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
