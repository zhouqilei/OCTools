//
//  AlertView.h
//  OCTools
//
//  Created by 周 on 2018/11/12.
//  Copyright © 2018年 周. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIView
+ (AlertView *)shareAlertView;
/**带有单按钮的弹出视图 颜色可以不填*/
- (void)alertWithTitle:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle btnTitleColor:(nullable UIColor *)btnTitleColor completion:(void(^)(void))completion;
/**带有双按钮的弹出视图 颜色可以不填*/
- (void)alertWIthTitle:(NSString *)title message:(NSString *)message leftBtnTitle:(NSString *)leftBtnTitle leftBtnTitleColor:(nullable UIColor *)leftBtnTitleColor leftBtnClicked:(void(^)(void))leftBtnClicked rightBtnTitle:(NSString *)rightBtnTitle rightBtnTitleColor:(nullable UIColor *)rightBtnTitleColor rightBtnClicked:(void(^)(void))rightBtnClicked;
@end

NS_ASSUME_NONNULL_END
