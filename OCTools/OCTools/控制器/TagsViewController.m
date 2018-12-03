//
//  TagsViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/26.
//  Copyright © 2018年 周. All rights reserved.
//

#import "TagsViewController.h"
#import "TagsView.h"
@interface TagsViewController ()<TagsViewDelegate>

@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TagsView *tagsV = [[TagsView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, 0) tagsArray:@[@"龙与地下城，初版（Dungeons &amp; Dragons），TSR公司发布",@"o 龙与地下城（基本，又称BD& D）",@"*龙与地下城起源版（Origin D&D，“0E”）",@" 龙与地下城，第三版",@"龙与地下城精华版",@"龙与地下城，第五版（Dungeons & Dragons 5th Edtion）"]];
    tagsV.canMultipleSelection = YES;
    tagsV.delegate = self;
    [self.view addSubview:tagsV];
}
#pragma mark TagsViewDelegate
- (void)tagsView:(TagsView *)view didSelectedTags:(NSArray *)tags {
    NSLog(@"%@",tags);
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
