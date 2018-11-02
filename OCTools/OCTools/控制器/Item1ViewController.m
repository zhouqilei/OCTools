//
//  Item1ViewController.m
//  OCTools
//
//  Created by 周 on 2018/10/31.
//  Copyright © 2018年 周. All rights reserved.
//

#import "Item1ViewController.h"

@interface Item1ViewController ()<UITableViewDelegate,UITableViewDataSource,BaseTableViewDelegate,DatePickerViewDelegate,AddressPickViewDelegate>
@property (nonatomic, strong)BaseTableView *tab;
@property (nonatomic, strong)NSArray *data;
@end

@implementation Item1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = @[@"自下向上弹出框",@"年月日选择器",@"年月选择器",@"地区选择器"];
    
    self.tab = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    self.tab.EventDelegate = self;
    self.tab.isNoData = YES;
    [self.view addSubview:self.tab];
}
#pragma mark - EventDelegate
- (void)refresh:(BaseTableView *)tableView {
    NSLog(@"刷新操作");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tab.mj_header endRefreshing];
    });
}
- (void)reload:(BaseTableView *)tableView {
    NSLog(@"加载操作");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tab.mj_footer endRefreshing];
    });
}
#pragma mark - UITableViewDelegate UITableViewDataSourece
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            UpView *upV = [[UpView alloc]init];
            [upV show];
        }
            break;
        case 1:
        {
            DatePickerView *dateV = [[DatePickerView alloc]init];
            dateV.contentHeight = 300.0f;
            dateV.dateStyle = DateStyleDate;
            dateV.delegate = self;
            [dateV show];
        }
            break;
        case 2:
        {
            DatePickerView *dateV = [[DatePickerView alloc]init];
            dateV.contentHeight = 300.0f;
            dateV.dateStyle = DateStyleYearAndMonth;
            dateV.delegate = self;
            [dateV show];
        }
            break;
        case 3:
        {
            AddressPickView *addressV = [[AddressPickView alloc]init];
            addressV.contentHeight = 300.0f;
            addressV.delegate = self;
            [addressV show];
        }
            break;
        default:
            break;
    }
}
#pragma mark - DatePickerViewDelegate
- (void)didClickSureWithYear:(NSInteger)year AndMonth:(NSInteger)month AndDay:(NSInteger)day {
    NSLog(@"%ld,%ld,%ld",(long)year,month,day);
}
#pragma mark - AddressPickViewDelegate
- (void)didClickSureWithProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area {
    NSLog(@"%@,%@,%@",province,city,area);
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
