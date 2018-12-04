//
//  Item2ViewController.m
//  OCTools
//
//  Created by 周 on 2018/10/31.
//  Copyright © 2018年 周. All rights reserved.
//

#import "Item2ViewController.h"
#import "AppDelegate.h"
#import "AuthorizationViewController.h"
#import "ChildControlViewController.h"
#import "CalendarViewController.h"
#import "SearchViewController.h"
#import "ScanViewController.h"
#import "BaseScanCodeViewController.h"
#import "FoldViewController.h"
#import "PhotoBrowserViewController.h"
#import "StepProgressViewController.h"
#import "WuLiuViewController.h"
#import "SuspensionView.h"
#import "TagsViewController.h"
#import "ProAttrSelectView.h"
#import "PlayViewController.h"
#import "FlexViewController.h"
#import "AddToCarViewController.h"
@interface Item2ViewController ()<UITableViewDelegate,UITableViewDataSource,ProAttrSelectViewDelegate>
@property (nonatomic, strong)BaseTableView *tab;
@property (nonatomic, strong)NSMutableArray *data;

@end

@implementation Item2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //接收网络变化的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNetworkStatus) name:kReachabilityChangedNotification object:nil];
    
    self.data = [NSMutableArray arrayWithArray:@[@"网络请求",@"网络状态",@"权限管理",@"继承系统控件的子类控件",@"日历",@"搜索",@"扫一扫",@"折叠cell",@"图片浏览器",@"步骤进度条",@"类似淘宝带有进度线的物流流程",@"简单的悬浮按钮实现",@"标签选择",@"商品购买属性选择弹框",@"简单的视频播放器",@"头部伸缩导航栏透明度渐变",@"添加产品到购物车动画"]];
    self.tab = [[BaseTableView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
    [self checkNetworkStatus];
    

}
#pragma mark - 网络变化通知方法
- (void)checkNetworkStatus {
    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NetworkStatus status = [del.coon currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            {
                [self.data replaceObjectAtIndex:1 withObject:@"网络状态（网络不可用）"];
                [self.tab reloadData];
            }
            break;
        case ReachableViaWiFi:
        {
            [self.data replaceObjectAtIndex:1 withObject:@"网络状态（wifi可用）"];
            [self.tab reloadData];
        }
            break;
        case ReachableViaWWAN:{
            [self.data replaceObjectAtIndex:1 withObject:@"网络状态（手机网络可用）"];
            [self.tab reloadData];
        }
            break;
        default:
            break;
    }
}

#pragma makr - UITableVIewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.data.count > 0) {
        self.tab.isNoData = NO;
    }else {
        self.tab.isNoData = YES;
    }
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            {
                [LoadingView show];
                [[RequestManager shareManager]postRequest:@"http://app.nbrainbow.xin/api/app/order-management/order-address-data" parameters:@{} success:^(id  _Nonnull responseObject) {
                    NSLog(@"%@",responseObject);
                    [LoadingView dismiss];
                } failure:^(NSError * _Nonnull error) {
                    [PromptView showPromptWithMessage:@"网络异常"];
                    [LoadingView dismiss];
                }];
            }
            break;
        case 2:
        {
            AuthorizationViewController *vc = [[AuthorizationViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            ChildControlViewController *vc = [[ChildControlViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            CalendarViewController *vc = [[CalendarViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            SearchViewController *vc = [[SearchViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            BaseScanCodeViewController *vc = [[BaseScanCodeViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            FoldViewController *vc = [[FoldViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:
        {
            PhotoBrowserViewController *vc = [[PhotoBrowserViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 9:
        {
            StepProgressViewController *vc = [[StepProgressViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10:
        {
            WuLiuViewController *vc = [[WuLiuViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 11:
        {
            SuspensionView *view = [[SuspensionView alloc]init];
            [view.suspensionBtn setTitle:@"哈哈" forState:UIControlStateNormal];
            [view.suspensionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [view show];
        }
            break;
        case 12:
        {
            TagsViewController *vc = [[TagsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 13:
        {
            ProAttrSelectView *view = [[ProAttrSelectView alloc]initWithData:@[
                            @{@"颜色":@[@"红色",@"白色",@"黑色",@"金色"]},
                            @{@"内存":@[@"16GB",@"32GB",@"64GB",@"128GB",@"256GB",@"512GB"]}
                            ]];
            view.delegate = self;
            [view show];
        }
            break;
        case 14:
        {
            PlayViewController *vc = [[PlayViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 15:
        {
            FlexViewController *vc = [[FlexViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 16:
        {
            AddToCarViewController *vc = [[AddToCarViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - delegate
- (void)proAttrSelectView:(ProAttrSelectView *)view didClickSureWithAttrs:(NSMutableArray *)attrs count:(NSInteger)count {
    NSLog(@"%@:%ld",attrs,(long)count);
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
