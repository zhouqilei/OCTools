//
//  BaseTableView.m
//  OCTools
//
//  Created by 周 on 2018/11/1.
//  Copyright © 2018年 周. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if ([super initWithFrame:frame style:style]) {
#pragma mark - 刷新
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if ([self.EventDelegate respondsToSelector:@selector(refresh:)]) {
                [self.EventDelegate refresh:self];
            }
        }];
#pragma mark - 加载
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if ([self.EventDelegate respondsToSelector:@selector(reload:)]) {
                [self.EventDelegate reload:self];
            }
        }];
#pragma mark - 有无数据提示
        [self addSubview:self.noDataLabel];
#pragma mark - tableview 设置
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
#pragma mark - 设置能否刷新
- (void)setEnableRefresh:(BOOL)enableRefresh {
    _enableRefresh = enableRefresh;
    if (_enableRefresh) {
        self.mj_header.hidden = NO;
    }else {
        self.mj_header.hidden = YES;
    }
}
#pragma mark - 设置能否加载
- (void)setEnableReloadData:(BOOL)enableReloadData {
    _enableReloadData = enableReloadData;
    if (_enableReloadData) {
        self.mj_footer.hidden = NO;
    }else {
        self.mj_footer.hidden = YES;
    }
}
#pragma mark - 设置是否有数据
- (void)setIsNoData:(BOOL)isNoData {
    _isNoData = isNoData;
    if (_isNoData) {
        self.noDataLabel.hidden = NO;
    }else {
        self.noDataLabel.hidden = YES;
    }
}
#pragma mark - 懒加载没有数据的提示
- (UILabel *)noDataLabel {
    if (!_noDataLabel) {
        _noDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.height - 40) / 2 , self.width, 40)];
        _noDataLabel.font = [UIFont systemFontOfSize:17];
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        _noDataLabel.text = @"暂无数据";
        _noDataLabel.textColor = [UIColor grayColor];
    }
    return _noDataLabel;
}
@end
