//
//  PromptView.m
//  OCTools
//
//  Created by 周 on 2018/11/6.
//  Copyright © 2018年 周. All rights reserved.
//

#import "PromptView.h"
@interface PromptView ()
@property (nonatomic, strong)UILabel *messageL;
@end
@implementation PromptView
+(PromptView *)sharedView{
    static PromptView *pv = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pv = [[PromptView alloc]init];
    });
    return pv;
}
- (instancetype)init {
    if ([super init]) {
        self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - HOME_INDICATOR_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        [[self lastWidow] addSubview:self];
        [self addSubview:self.messageL];
    }
    return self;
}
- (UILabel *)messageL {
    if (!_messageL) {
        _messageL = [[UILabel alloc]init];
        _messageL.backgroundColor = [UIColor blackColor];
        _messageL.alpha = 0.7;
        _messageL.layer.cornerRadius = 5;
        _messageL.layer.masksToBounds = YES;
        _messageL.textColor = [UIColor whiteColor];
        _messageL.textAlignment = NSTextAlignmentCenter;
        _messageL.numberOfLines = 0;
        _messageL.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _messageL;
}
+ (void)showPromptWithMessage:(NSString *)message {
    [[self sharedView] showMessage:message];
}
- (void)showMessage:(NSString *)message{
    self.hidden = NO;
    self.messageL.text = message;
    CGFloat maxWidth = UI_SCREEN_WIDTH - 60;
    CGSize size = [self.messageL sizeThatFits:CGSizeMake(UI_SCREEN_WIDTH, CGFLOAT_MAX)];
    if (size.width + 20 > maxWidth) {
        size = [self.messageL sizeThatFits:CGSizeMake(maxWidth - 20, CGFLOAT_MAX)];
        self.messageL.frame = CGRectMake((UI_SCREEN_WIDTH - maxWidth) / 2, (self.height - (size.height + 20)) / 2, maxWidth, size.height + 20);
    }else {
        self.messageL.frame = CGRectMake((UI_SCREEN_WIDTH - (size.width + 20)) / 2, (self.height - (size.height + 20)) / 2, size.width + 20, size.height + 20);
    }
    
//    [UIView animateWithDuration:0.2 delay:message.length * 0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        [self.messageL removeFromSuperview];
//        self.hidden = YES;
//    } completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * message.length * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1 animations:^{
            self.hidden = YES;
        }];
    });
    
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
