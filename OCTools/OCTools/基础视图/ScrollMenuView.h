//
//  ScrollMenuView.h
//  OCTools
//
//  Created by 周 on 2018/11/5.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ScrollMenuViewStyle){
    ScrollMenuViewStyleDefault,
    ScrollMenuViewStyleValue1,
    ScrollMenuViewStyleValue2,
    ScrollMenuViewStyleValue3
};
@class ScrollMenuView;
@protocol ScrollMenuViewDelegate <NSObject>
- (void)scrollMenuView:(ScrollMenuView *)view didClickItemAtIndex:(NSInteger )index;
@end
@interface ScrollMenuView : UIView
/**当前菜单下标*/
@property (nonatomic, assign)NSInteger currentIndex;
/**菜单名称数组*/
@property (nonatomic, strong)NSArray *items;

@property (nonatomic, weak)id<ScrollMenuViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
