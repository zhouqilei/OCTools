//
//  AuthorizationViewController.m
//  OCTools
//
//  Created by 周 on 2018/11/9.
//  Copyright © 2018年 周. All rights reserved.
//

#import "AuthorizationViewController.h"

@interface AuthorizationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tab;
@property (nonatomic, strong)NSMutableArray *data;
@end

@implementation AuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.data = [NSMutableArray arrayWithObjects:@"相机（无权限）",@"相册（无权限）",@"定位（无权限）", nil];
    
    if ([[AuthorizationManager manager] canUseCamera] == AuthorizationStatusAuthorized) {
        [self.data replaceObjectAtIndex:0 withObject:@"相机（有权限）"];
    }
    if ([[AuthorizationManager manager] canUsePhotoLibrary] == AuthorizationStatusAuthorized) {
        [self.data replaceObjectAtIndex:1 withObject:@"相册（有权限）"];
    }
    if ([[AuthorizationManager manager] canUseLocation] == AuthorizationStatusAuthorized) {
        [self.data replaceObjectAtIndex:2 withObject:@"相册（有权限）"];
    }
    
    self.tab = [[UITableView alloc]initWithFrame:CGRectMake(0, HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HeightForNagivationBarAndStatusBar - HOME_INDICATOR_HEIGHT) style:UITableViewStylePlain];
    self.tab.delegate = self;
    self.tab.dataSource = self;
    [self.view addSubview:self.tab];
}
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
                [[AuthorizationManager manager] requestAuthorizationForCamera];
            }
            break;
        case 1:
            {
                [[AuthorizationManager manager] requestAuthorizationForPhotoLibrary];
            }
            break;
        case 2:
            {
                [[AuthorizationManager manager] requestAuthorizationForLocation];
            }
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
