//
//  Item2ViewController.m
//  OCTools
//
//  Created by 周 on 2018/10/31.
//  Copyright © 2018年 周. All rights reserved.
//

#import "Item2ViewController.h"

@interface Item2ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)BaseTableView *tab;
@property (nonatomic, strong)NSArray *data;
@end

@implementation Item2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = @[@"网络请求"];
    self.tab = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
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
            
        default:
            break;
    }
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
