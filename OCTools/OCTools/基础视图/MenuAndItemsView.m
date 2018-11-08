//
//  MenuAndItemsView.m
//  OCTools
//
//  Created by 周 on 2018/11/8.
//  Copyright © 2018年 周. All rights reserved.
//

#import "MenuAndItemsView.h"
@interface MenuAndItemsView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MenuAndItemsView
- (instancetype)initWithFrame:(CGRect)frame andMenu:(NSArray *)menuArray items:(NSArray *)itemsArray {
    if ([super initWithFrame:frame]) {
        self.menuArray = menuArray;
        self.itemsArray = itemsArray;
        
        [self addSubview:self.menuTab];
        [self addSubview:self.itemTab];
    }
    return self;
}
#pragma mark - UITableViewDelegate UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.menuTab) {
        return 80;
    }else {
        return 120;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.menuTab) {
        return 1;
    }else {
        return self.itemsArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.menuTab) {
        return self.menuArray.count;
    }else {
        NSDictionary *itemDic = self.itemsArray[section];
        NSArray *items = itemDic.allValues.firstObject;
        return items.count;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.itemTab) {
        NSDictionary *itemDic = self.itemsArray[section];
        return itemDic.allKeys.firstObject;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.menuTab) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuCell"];
            if (indexPath.row == 0) {
                cell.backgroundColor = [UIColor whiteColor];
            }else {
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
            cell.textLabel.text = self.menuArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            NSDictionary *itemDic = self.itemsArray[indexPath.section];
            NSArray *items = itemDic.allValues.firstObject;
            cell.textLabel.text = items[indexPath.row];
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (tableView == self.menuTab) {
        //设置背景颜色
        for (NSIndexPath *index in tableView.indexPathsForVisibleRows) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:index];
            if (index == indexPath) {
                cell.backgroundColor = [UIColor whiteColor];
            }else {
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
        }
        //设置滚动
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.itemTab scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
        //代理
        if ([self.delegate respondsToSelector:@selector(menuAndItemsView:didClickMenuAtIndexPath:)]) {
            [self.delegate menuAndItemsView:self didClickMenuAtIndexPath:indexPath];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(menuAndItemsView:didClickItemAtIndexPaht:)]) {
            [self.delegate menuAndItemsView:self didClickItemAtIndexPaht:indexPath];
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    //根据右边列表即将展示的header来改变左边列表的选中状态
    NSIndexPath *index = [NSIndexPath indexPathForRow:section inSection:0];
    [self.menuTab scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    for (NSIndexPath *indexPath in self.menuTab.indexPathsForVisibleRows) {
        UITableViewCell *menuCell = [self.menuTab cellForRowAtIndexPath:indexPath];
        if (index == indexPath) {
            menuCell.backgroundColor = [UIColor whiteColor];
        }else {
            menuCell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
    }
}
#pragma mark - 懒加载视图
- (UITableView *)menuTab {
    if (!_menuTab) {
        _menuTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width * PROPORTION, self.frame.size.height) style:UITableViewStylePlain];
        _menuTab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _menuTab.delegate = self;
        _menuTab.dataSource = self;
        _menuTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _menuTab;
}

- (UITableView *)itemTab {
    if (!_itemTab) {
        _itemTab = [[UITableView alloc]initWithFrame:CGRectMake(self.frame.size.width * PROPORTION, 0, self.frame.size.width *(1 - PROPORTION), self.frame.size.height) style:UITableViewStylePlain];
        _itemTab.backgroundColor = [UIColor whiteColor];
        _itemTab.delegate = self;
        _itemTab.dataSource = self;
        _itemTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _itemTab.separatorColor = [UIColor grayColor];
    }
    return _itemTab;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
