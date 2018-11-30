//
//  PlayViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/29.
//  Copyright © 2018年 周. All rights reserved.
//

#import "PlayViewController.h"
#import "PlayView.h"
@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PlayView *playV = [[PlayView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 250)];
    [playV playWith:[NSURL URLWithString:@"http://pri-video.v.medlinker.net/5595b16d-72bc-4fcb-bef2-c01327abeab3/10.m3u8"]];
    [self.view addSubview:playV];
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
