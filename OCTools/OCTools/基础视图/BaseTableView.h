//
//  BaseTableView.h
//  OCTools
//
//  Created by 周 on 2018/11/1.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseTableView;
NS_ASSUME_NONNULL_BEGIN
@protocol BaseTableViewDelegate <NSObject>

@optional
//下拉刷新
- (void)refresh:(BaseTableView *)tableView;
//上拉加载
- (void)reload:(BaseTableView *)tableView;

@end
@interface BaseTableView : UITableView
//能否刷新
@property (nonatomic, assign)BOOL enableRefresh;
//能否加载
@property (nonatomic, assign)BOOL enableReloadData;
//是否有数据
@property (nonatomic, assign)BOOL isNoData;
@property (nonatomic, weak)id<BaseTableViewDelegate>EventDelegate;
@property (nonatomic, strong)UILabel *noDataLabel;
@end

NS_ASSUME_NONNULL_END
