//
//  MenuAndItemsView.h
//  OCTools
//
//  Created by 周 on 2018/11/8.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**左边菜单对右边内容的宽度比例*/
#define PROPORTION 1/5
@class MenuAndItemsView;
@protocol MenuAndItemsViewDelegate <NSObject>

@optional
/**左边的列表被点击*/
- (void)menuAndItemsView:(MenuAndItemsView *)view didClickMenuAtIndexPath:(NSIndexPath *)indexPath;
/**右边的列表被点击*/
- (void)menuAndItemsView:(MenuAndItemsView *)view didClickItemAtIndexPaht:(NSIndexPath *)indexPath;
@end

@interface MenuAndItemsView : UIView
/**菜单列表*/
@property (nonatomic, strong)UITableView *menuTab;
/**内容列表*/
@property (nonatomic, strong)UITableView *itemTab;
/**菜单*/
@property (nonatomic, strong)NSArray *menuArray;
/**内容*/
@property (nonatomic, strong)NSArray *itemsArray;
/**代理*/
@property (nonatomic, weak)id<MenuAndItemsViewDelegate>delegate;
/**初始化*/
- (instancetype)initWithFrame:(CGRect)frame andMenu:(NSArray *)menuArray items:(NSArray *)itemsArray;
@end

NS_ASSUME_NONNULL_END
