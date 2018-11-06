//
//  RemindView.m
//  OCTools
//
//  Created by 周 on 2018/11/6.
//  Copyright © 2018年 周. All rights reserved.
//

#import "RemindView.h"
@interface RemindView ()
@property (nonatomic, strong)NSArray *imageArray;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *messageL;
@end
@implementation RemindView
+ (RemindView *)shareRemindView {
    static RemindView *rv = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rv = [[RemindView alloc]init];
    });
    return rv;
}
/**图片数组懒加载*/
- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"pc_success",@"pc_error",@"pc_warning"];
    }
    return _imageArray;
}
/**初始化*/
- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, - HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, HeightForNagivationBarAndStatusBar);
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.shadowOffset = CGSizeMake(1, 3);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowColor = App_Main_Color.CGColor;
        
        [[self lastWidow] addSubview:self];
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 40, 40)];
        [self addSubview:self.imageV];
        
        self.messageL = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, UI_SCREEN_WIDTH - 100, HeightForNagivationBarAndStatusBar)];
        self.messageL.numberOfLines = 0;
        self.messageL.lineBreakMode = NSLineBreakByWordWrapping;
        self.messageL.font = [UIFont systemFontOfSize:15];
        self.messageL.textColor = [UIColor blackColor];
        [self addSubview:self.messageL];
        
    }
    return self;
}
/**设置消息类型及消息内容*/
- (void)setMessageType:(MessageType)messageType andMessage:(NSString *)message {
    self.imageV.image = [UIImage imageNamed:self.imageArray[messageType]];
    self.messageL.text = message;
}
/**弹窗弹出*/
- (void)show {
    self.frame = CGRectMake(0, -HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, HeightForNagivationBarAndStatusBar);
    [self.layer removeAllAnimations];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, HeightForNagivationBarAndStatusBar);
    } completion:^(BOOL finished) {
        [self dismiss];
    }];
}
/**弹窗隐藏*/
- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0, -HeightForNagivationBarAndStatusBar, UI_SCREEN_WIDTH, HeightForNagivationBarAndStatusBar);
    } completion:nil];
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
