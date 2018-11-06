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
    /**没有底部线*/
    ScrollMenuViewStyleDefault,
    /**底部线的宽度=视图宽度 / 菜单数量*/
    ScrollMenuViewStyleValue1,
    /**底部线的宽度固定*/
    ScrollMenuViewStyleValue2,
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

/**初始化*/
- (instancetype)initWithFrame:(CGRect)frame andStyle:(ScrollMenuViewStyle)style;
@end


@interface ScrollMenuButton : UIButton
+(instancetype)defaultStyleButtonWithTitle:(NSString *)title;
@end
NS_ASSUME_NONNULL_END
