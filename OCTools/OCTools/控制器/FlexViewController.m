//
//  FlexViewController.m
//  OCTools
//
//  Created by 周 on 2018/12/3.
//  Copyright © 2018年 周. All rights reserved.
//

#import "FlexViewController.h"
//当scrollview的图片被完全移动走
#define NAVBAR_COLORCHANGE_POINT (- UI_SCREEN_HEIGHT / 3 + HeightForNagivationBarAndStatusBar)
//可以下拉多少
#define LIMIT_OFFSETY -(UI_SCREEN_HEIGHT / 3 + 100)
@interface FlexViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UIImageView *headerV;
@property (nonatomic, strong)UITableView *tableV;
@end

@implementation FlexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置nav透明
    [self wr_setNavBarBackgroundAlpha:0];
    //设置图片
    self.headerV = [[UIImageView alloc]initWithFrame:CGRectMake(0, - UI_SCREEN_HEIGHT / 3 - HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT / 3)];
    self.headerV.image = [UIImage imageNamed:@"icon-bj"];
    self.headerV.contentMode = UIViewContentModeScaleAspectFill;
    self.headerV.layer.masksToBounds = YES;
    self.headerV.autoresizesSubviews = YES;
    
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT  - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    self.tableV.contentInset = UIEdgeInsetsMake(self.headerV.height, 0, 0, 0);
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    [self.tableV addSubview:self.headerV];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / HeightForNagivationBarAndStatusBar;
        [self wr_setNavBarBackgroundAlpha:alpha];
    }else{
        [self wr_setNavBarBackgroundAlpha:0];
    }
    //限制下拉
    if (offsetY < LIMIT_OFFSETY) {
        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSETY)];
    }
    
    CGFloat newOffsetY = scrollView.contentOffset.y;
    if (newOffsetY < - UI_SCREEN_HEIGHT / 3) {
        self.headerV.frame = CGRectMake(0, newOffsetY, UI_SCREEN_WIDTH, - newOffsetY);
    }
}
#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = [NSString stringWithFormat:@"WRNavigationBar %zd",indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
