//
//  UpView.m
//  OCTools
//
//  Created by 周 on 2018/11/1.
//  Copyright © 2018年 周. All rights reserved.
//

#import "UpView.h"

@implementation UpView
- (instancetype)init {
    if ([super init]) {
        [self setUpView];
    }
    return self;
}
#pragma mark - 设置界面
- (void)setUpView{
    self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT);
    self.backgroundColor =  RGBA(0, 0, 0, 0.4);
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
    [self addSubview:self.contentView];
}
#pragma makr - 懒加载内容视图
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT, UI_SCREEN_WIDTH, self.contentHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        
    }
    return _contentView;
}
#pragma mark - 弹出视图
- (void)show {
    if (!self.contentHeight) {
        self.contentHeight = 210.f;
    }
    [[self lastWidow] addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT - self.contentHeight, UI_SCREEN_WIDTH, self.contentHeight)];
    }];
}
#pragma mark - 隐藏视图
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setFrame:CGRectMake(0, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT, UI_SCREEN_WIDTH, self.contentHeight)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 获取最上层window
- (UIWindow *)lastWidow{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] && CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)) {
            return window;
        }
    }
    return [UIApplication sharedApplication].keyWindow;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
