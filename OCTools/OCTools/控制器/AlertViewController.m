//
//  UIAlertViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import "AlertViewController.h"

@interface AlertViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tab;
@property (nonatomic, strong)NSArray *data;
@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = @[@"只有单按钮的提示窗",@"双按钮提示窗"];
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
}
#pragma UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [[AlertView shareAlertView]alertWithTitle:@"提示" message:@"单按钮提示框" btnTitle:@"确定" btnTitleColor:[UIColor orangeColor] completion:^{
                NSLog(@"按钮被点击了");
            }];
        }
            break;
        case 1:
        {
            [[AlertView shareAlertView]alertWIthTitle:@"提示" message:@"双按钮提示" leftBtnTitle:@"取消" leftBtnTitleColor:[UIColor redColor] leftBtnClicked:^{
                NSLog(@"左按钮点击了");
            } rightBtnTitle:@"确定" rightBtnTitleColor:nil rightBtnClicked:^{
                NSLog(@"右按钮点击了");
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
