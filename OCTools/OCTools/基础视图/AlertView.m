//
//  AlertView.m
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (AlertView *)shareAlertView {
    static AlertView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[AlertView alloc]init];
        
    });
    return view;
}
- (void)alertWithTitle:(NSString *)title message:(NSString *)message btnTitle:(nonnull NSString *)btnTitle btnTitleColor:(nullable UIColor*)btnTitleColor  completion:(void (^)(void))completion {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completion();
    }];
    if (btnTitleColor) {
        [action setValue:btnTitleColor  forKey:@"_titleTextColor"];
    }
    [alertC addAction:action];
    [[AlertView shareAlertView].viewController presentViewController:alertC animated:YES completion:nil];
}
- (void)alertWIthTitle:(NSString *)title message:(NSString *)message leftBtnTitle:(NSString *)leftBtnTitle leftBtnTitleColor:(nullable UIColor *)leftBtnTitleColor leftBtnClicked:(void (^)(void))leftBtnClicked rightBtnTitle:(NSString *)rightBtnTitle rightBtnTitleColor:(nullable UIColor *)rightBtnTitleColor rightBtnClicked:(void (^)(void))rightBtnClicked {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:leftBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        leftBtnClicked();
    }];
    if (leftBtnTitleColor) {
        [action1 setValue:leftBtnTitleColor forKey:@"_titleTextColor"];
    }
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:rightBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        rightBtnClicked();
    }];
    if (rightBtnTitleColor) {
        [action2 setValue:rightBtnTitleColor forKey:@"_titleTextColor"];
    }
    
    [alertC addAction:action1];
    [alertC addAction:action2];
    
    [[AlertView shareAlertView].viewController presentViewController:alertC animated:YES completion:nil];
}
#pragma 获取当前的视图控制器
- (UIViewController *)viewController {
    UIViewController *vc = [[UIApplication sharedApplication].keyWindow rootViewController];
    return vc;
}
@end
