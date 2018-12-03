//
//  CycleViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import "CycleViewController.h"
#import "SDCycleScrollView.h"
@interface CycleViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollV;
@end

@implementation CycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT)];
    self.scrollV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.scrollV.contentSize = CGSizeMake(UI_SCREEN_WIDTH, 1000.0f);
    [self.view addSubview:self.scrollV];
    //图片轮播图 左右
    SDCycleScrollView *s1 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 200) imageURLStringsGroup:@[@"http://pic.pptbz.com/201411/2014111480335169.JPG",@"http://pic1.win4000.com/wallpaper/a/57ddf2ca81d13.jpg",@"http://image.qqtu8.com/allimg/2018-pic_tupian1/18-tupian1_21124.jpg"]];
    s1.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    s1.delegate = self;
    [self.scrollV addSubview:s1];
    //文字轮播图 上下
    SDCycleScrollView *s2 = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 300, UI_SCREEN_WIDTH, 40)];
    s2.onlyDisplayText = YES;
    s2.showPageControl = NO;
    s2.titlesGroup = @[@"文字信息1",@"文字信息2",@"文字信息3"];
    s2.scrollDirection = UICollectionViewScrollDirectionVertical;
    s2.delegate = self;
    [self.scrollV addSubview:s2];
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%ld", index);
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
