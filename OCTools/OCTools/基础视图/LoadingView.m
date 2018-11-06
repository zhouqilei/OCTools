//
//  LoadingView.m
//  OCTools
//
//  Created by 周 on 2018/11/6.
//  Copyright © 2018年 周. All rights reserved.
//

#import "LoadingView.h"
@interface LoadingView ()
@property (nonatomic, strong)UIActivityIndicatorView *aiv;
@end
@implementation LoadingView
+ (LoadingView *)sharedView {
    static LoadingView *lv = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lv = [[LoadingView alloc]init];
    });
    return  lv;
}
/**初始化*/
- (instancetype)init {
    if ([super init]) {
        self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        [[self lastWidow] addSubview:self];
        [self addSubview:self.aiv];
    }
    return self;
}
- (UIActivityIndicatorView *)aiv {
    if (!_aiv) {
        /**设置菊花样式*/
        _aiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _aiv.color = [UIColor blackColor];
//        _aiv.backgroundColor = [UIColor grayColor];
        _aiv.center = self.center;
        _aiv.hidesWhenStopped = YES;
        //使用仿射变换放大菊花图
        CGAffineTransform transform = CGAffineTransformMakeScale(1.2, 1.2);
        _aiv.transform = transform;
    }
    return _aiv;
}
/**展示菊花图*/
+ (void)show {
    [[self sharedView] showLoadingView];
}
- (void)showLoadingView {
    self.hidden = NO;
    [self.aiv startAnimating];
}
/**隐藏菊花图*/
+ (void)dismiss {
    [[self sharedView] dismissLoadingView];
}
- (void)dismissLoadingView {
    self.hidden = YES;
    [self.aiv stopAnimating];
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
